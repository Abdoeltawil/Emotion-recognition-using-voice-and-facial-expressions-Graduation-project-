from flask import Flask, request, jsonify,session
import moviepy.editor as mp
from pydub import AudioSegment
import cv2
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
# %matplotlib inline
import os
from keras.models import Sequential
from keras.utils import np_utils
import tensorflow
from tensorflow import nn
from keras.layers import Activation
from keras.utils.generic_utils import get_custom_objects
from keras import backend as K
import shutil
from sklearn.preprocessing import StandardScaler, LabelEncoder
import pandas as pd
import numpy as np
import urllib
import tempfile
import base64

def intilaiz(name):


    """The next sell is to delete the Output Folder if I want to """
    import Pyrebase.pyrebase
    firebaseConfig = {
        'apiKey': "AIzaSyBXT-wbRGSVexZ-LGhrAUSi0zC2TFw8JS4",
        'authDomain': "gproject-3911e.firebaseapp.com",
        'projectId': "gproject-3911e",
        'storageBucket': "gproject-3911e.appspot.com",
        'messagingSenderId': "594868892580",
        'appId': "1:594868892580:web:adc29067f5aa1beba30731",
        'measurementId': "G-4CXD3JGLY3",
        'databaseURL': 'https://console.firebase.google.com/project/gproject-3911e/storage/gproject-3911e.appspot.com/files'
    };

    firebase = Pyrebase.pyrebase.initialize_app(firebaseConfig)

    storage = firebase.storage()
    path = storage.child(name).get_url(None)
    f = urllib.request.urlopen(path).read()


    temp_path = tempfile.gettempdir()
    video_binary_string = f
    decoded_string = base64.b64decode(video_binary_string)

    with open('./' + str(request.args['query']), 'wb') as wfile:
        wfile.write(f)

    path = "E:/deep/flask/video/" + str(request.args['query'])

    stringSplit = path.split("/")
    stringSplit
    video = stringSplit[-1]
    video
    videoName = video.split(".")[0]
    videoName
    pathToTheVideo = '/'.join(stringSplit[:-1]) + '/'
    pathToTheVideo
    return videoName,pathToTheVideo,str(request.args['query'])

def image_emotion(videoName,pathToTheVideo):
    """## Video Model"""

    # Commented out IPython magic to ensure Python compatibility.


    # def swish_activation(x):
    #     return (K.sigmoid(x) * x)
    #
    #
    # get_custom_objects().update({'swish_activation': Activation(swish_activation)})

    model = tensorflow.keras.models.load_model('E:/deep/flask/video/imagefinall.h5')

    class Frame:
        """class to hold information about each frame

        """

        def __init__(self, id, diff):
            self.id = id
            self.diff = diff

        def __lt__(self, other):
            if self.id == other.id:
                return self.id < other.id
            return self.id < other.id

        def __gt__(self, other):
            return other.__lt__(self)

        def __eq__(self, other):
            return self.id == other.id and self.id == other.id

        def __ne__(self, other):
            return not self.__eq__(other)

    def rel_change(a, b):
        x = (b - a) / max(a, b)
        return x

    import operator
    from scipy.signal import argrelextrema
    USE_THRESH = True
    # fixed threshold value
    THRESH = 0.4
    NUM_TOP_FRAMES = 50

    # Video path of the source file
    videopath = pathToTheVideo + videoName + ".mp4"
    # Directory to store the processed frames
    dir = './'
    # smoothing window size
    len_window = int(50)

    arr = [0]
    print("target video :" + videopath)
    print("frame save directory: " + dir)
    # load video and compute diff between frames
    cap = cv2.VideoCapture(str(videopath))
    fps = cap.get(cv2.CAP_PROP_FPS)
    curr_frame = None
    prev_frame = None
    frame_diffs = []
    frames = []
    framess = []
    success, frame = cap.read()
    i = 0
    print(success)
    while (success):
        luv = cv2.cvtColor(frame, cv2.COLOR_BGR2LUV)
        curr_frame = luv
        if curr_frame is not None and prev_frame is not None:
            # logic here
            #         print("Hi")
            diff = cv2.absdiff(curr_frame, prev_frame)
            diff_sum = np.sum(diff)
            diff_sum_mean = diff_sum / (diff.shape[0] * diff.shape[1])
            frame_diffs.append(diff_sum_mean)
            framess.append(frame)
            frame = Frame(i, diff_sum_mean)
            frames.append(frame)

        prev_frame = curr_frame
        i = i + 1
        # arr.append(frame)
        success, frame = cap.read()
    cap.release()

    # print(frames[0].diff)
    # for i in range(1, len(frames)):
    #     print(frames[i].diff)

    # compute keyframe
    keyframe_id_set = set()
    if USE_THRESH:
        for i in range(1, len(frames) - 1):
            #         if (frames[i-1].diff == 0):
            #             frames[i-1].diff = 0.00001
            #         counter_helper = counter_helper + 1
            if (rel_change(float(frames[i - 1].diff), float(frames[i].diff)) >= THRESH):
                keyframe_id_set.add(frames[i].id)
                arr.append(frames[i].id)

    arr.append(len(frames) - 1)

    print(arr)

    len(framess)

    emotion_dict = {0: 'anger', 1: 'disgust', 2: 'fear',
                    3: 'happy', 4: 'Sad',
                    5: 'surprise', 6: 'neutral'}
    face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
    ind = 0
    i = 0
    z = 0

    angerCount = 0
    disgustCount = 0
    fearCount = 0
    happyCount = 0
    sadCount = 0
    surpriceCount = 0
    neutralCount = 0

    dirr = videoName
    try:
        os.makedirs(dirr)
    except:
        print("File Already Exists")
    for n in arr:
        #     print(n)
        faces = face_cascade.detectMultiScale(framess[n], 1.1, 4)
        emoo = ''
        for (x, y, w, h) in faces:
            # cv2.rectangle(frame, (x, y), (x + w, y + h), (255, 0, 0), 2)
            roi_gray = framess[n][y:y + h, x:x + w]
            image_48 = cv2.resize(roi_gray, (48, 48))
            gray = cv2.cvtColor(image_48, cv2.COLOR_BGR2GRAY)
            image_48 = gray / 255
            img_48 = image_48.reshape(1, 48, 48, 1)
            prediction = model.predict(img_48)
            emotion = emotion_dict[np.argmax(prediction)]
            emoo = emotion

        if (i < len(arr) - 1):
            while (ind < arr[i + 1]):

                cv2.putText(framess[ind], emoo, (20, 20), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2, cv2.LINE_AA)

                if emoo == "anger":
                    angerCount = angerCount + 1
                elif emoo == "disgust":
                    disgustCount = disgustCount + 1
                elif emoo == "fear":
                    fearCount = fearCount + 1
                elif emoo == "happy":
                    happyCount = happyCount + 1
                elif emoo == "Sad":
                    sadCount = sadCount + 1
                elif emoo == "surprise":
                    surpriseCount = surpriseCount + 1
                elif emoo == "neutral":
                    neutralCount = neutralCount + 1

                directory = dirr + '/Frame' + str(ind) + '.jpg'
                cv2.imwrite(directory, framess[ind])
                ind += 1

            i = i + 1

    happyCount

    # Create Predictions\
    # emoo_arr -> 'anger', 1: 'disgust', 2: 'fear', 3: 'happy', 4: 'Sad',5: 'surprise', 6: 'neutral'
    # Video emotions -> anger, disgust, fear, happy, neutral, sad, surprise

    emoo_arr = [angerCount, disgustCount, fearCount, happyCount, neutralCount, sadCount, surpriceCount]
    emoo_arr = np.array(emoo_arr)
    emoo_arr = emoo_arr / len(framess)
    emoo_arr



    import glob
    globDir = "./" + videoName
    # x=glob.glob(dir)
    x = os.listdir(dirr)
    img_array = []
    for i in range(len(x) - 1):
        #     ./received_1441314836271880/Frame173.jpg
        filename = '/Frame' + str(i) + '.jpg'
        fileee = globDir + filename
        img = cv2.imread(fileee)
        height, width, layers = img.shape
        size = (width, height)
        img_array.append(img)

    # os.listdir(directory)

    outputname = videoName + ".avi"
    out = cv2.VideoWriter(outputname, cv2.VideoWriter_fourcc(*'MPEG'), fps, size)
    for i in range(len(img_array)):
        out.write(img_array[i])
    out.release()

    return emoo_arr

def audio_emotion(videoName,pathToTheVideo,full_video_name):
    extention=full_video_name.split(".")
    if(extention[len(extention)-1]=='mp4'):
        dir_path = './' + videoName
        try:
            shutil.rmtree(dir_path)
        except OSError as e:
            print("Error: %s : %s" % (dir_path, e.strerror))
        # videoName = "KATIE perry"
        te = pathToTheVideo + videoName + ".mp4"
        myClip = mp.VideoFileClip(te)
        ctr = 0
        sttr = videoName + ".mp3"
        myClip.audio.write_audiofile(sttr)
        src = 'E:/deep/flask/video/' + sttr
        sttrWAV = videoName + ".wav"
        dst = sttrWAV
        print(src)
        sound = AudioSegment.from_mp3(src)
        sound.export(dst, format="wav")
        ctr = ctr + 1
    """## Audio Model"""

    soundModel = tensorflow.keras.models.load_model('E:/deep/flask/video/TestSound.h5')

    def extract_features(data):
        # ZCR
        result = np.array([])
        zcr = np.mean(librosa.feature.zero_crossing_rate(y=data).T, axis=0)
        result = np.hstack((result, zcr))  # stacking horizontally

        # Chroma_stft
        stft = np.abs(librosa.stft(data))
        chroma_stft = np.mean(librosa.feature.chroma_stft(S=stft, sr=sample_rate).T, axis=0)
        result = np.hstack((result, chroma_stft))  # stacking horizontally

        # MFCC
        mfcc = np.mean(librosa.feature.mfcc(y=data, sr=sample_rate).T, axis=0)
        result = np.hstack((result, mfcc))  # stacking horizontally

        # Root Mean Square Value
        rms = np.mean(librosa.feature.rms(y=data).T, axis=0)
        result = np.hstack((result, rms))  # stacking horizontally

        # MelSpectogram
        mel = np.mean(librosa.feature.melspectrogram(y=data, sr=sample_rate).T, axis=0)
        result = np.hstack((result, mel))  # stacking horizontally

        return result


    Features = pd.read_csv("E:/deep/flask/video/features.csv")
    X = Features.iloc[:, :-1].values
    Y = Features['labels'].values
    encoder = LabelEncoder()
    Y = encoder.fit_transform(np.array(Y).reshape(-1, 1))

    import librosa
    audioName = videoName + ".wav"
    data, sample_rate = librosa.load(audioName)
    print(audioName)

    feature = extract_features(data)
    feature = np.expand_dims(feature, axis=0)
    feature = np.expand_dims(feature, axis=2)

    print(encoder.transform(['angry', 'disgust', 'fear', 'happy', 'neutral', 'sad', 'surprise']))

    """## The emotion in order
    #### ( anger, disgust, fear, happy, neutral, sad, surprise )
    """
    outcome_emotion_dict = {0: 'anger', 1: 'disgust', 2: 'fear', 3: 'happy', 4: 'neutral', 5: 'Sad', 6: 'surprise'}

    predd = soundModel.predict(feature)
    # print("Audio Model Predicted: ", encoder.inverse_transform(predd))
    predd

    return predd



app = Flask(__name__)
@app.route('/api-image', methods = ['GET'])
def return_image_emotion():
    videoName,pathToTheVideo,full_video_name=intilaiz(str(request.args['query']))
    outcome=image_emotion(videoName,pathToTheVideo)
    outcome_emotion_dict = {0: 'anger', 1: 'disgust', 2: 'fear', 3: 'happy', 4: 'neutral', 5: 'Sad', 6: 'surprise'}
    mx = np.argmax(outcome)
    os.remove(videoName+'.mp4')
    d = {}
    d['output'] = outcome_emotion_dict[mx]
    return d

@app.route('/api-audio', methods = ['GET'])
def return_audio_emotion():
    videoName,pathToTheVideo,full_video_name=intilaiz(str(request.args['query']))
    pred=audio_emotion(videoName,pathToTheVideo,full_video_name)
    c = np.argmax(pred)
    outcome_emotion_dict = {0: 'anger', 1: 'disgust', 2: 'fear', 3: 'happy', 4: 'neutral', 5: 'Sad', 6: 'surprise'}
    os.remove(videoName+'.mp3')
    os.remove(videoName + '.wav')
    d = {}
    d['output'] = outcome_emotion_dict[c]
    return d

@app.route('/api-video', methods = ['GET'])
def return_video_emotion():
    # np.array(predd[0][2] + emoo_arr[2])
    videoName, pathToTheVideo, full_video_name = intilaiz(str(request.args['query']))
    emoo_arr = image_emotion(videoName, pathToTheVideo)
    predd=audio_emotion(videoName,pathToTheVideo,full_video_name)
    outcome = predd[0] + emoo_arr
    c = np.argmax(predd)
    c
    outcome_emotion_dict = {0: 'anger', 1: 'disgust', 2: 'fear', 3: 'happy', 4: 'neutral', 5: 'Sad', 6: 'surprise'}
    outcome
    mx = np.argmax(outcome)
    print("Preicted total emotion: ", outcome_emotion_dict[mx])
    import glob
    for i in glob.glob("*"):
        lenn=i.split('.')
        if(lenn[len(lenn)-1]=='mp3' or lenn[len(lenn)-1]=='wav'):
            os.remove(i)
    d = {}
    d['output'] = outcome_emotion_dict[mx]
    return d


if __name__ =="__main__":
    app.debug = True
    app.run(host="0.0.0.0")  # host="0.0.0.0" will make the page accessable
    # by going to http://[ip]:5000/ on any computer in
    # the network.



