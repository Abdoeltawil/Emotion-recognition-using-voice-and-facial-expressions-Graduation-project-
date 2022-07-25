import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icon.dart";

//Welcome User
Widget welcomingUser(String userName) {
  return FittedBox(
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: 60,
        height: 60,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xffE6E6E6),
          child: Icon(
            Icons.person,
            color: Colors.grey[600],
          ),
        ),
      ),
      SizedBox(width: 20),
      Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(children: [
          FittedBox(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                userName,
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          SizedBox(height: 60),
        ]),
      ),
    ]),
  );
}
//End Welcome User

//Top Box
Widget firstBox(Color clr) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: clr,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: Column(
        children: [
          Text(
            "Last Time You Were Here\nYou Were:",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: Colors.white70,
              fontSize: 22,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Happy",
            style: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
        ],
      ),
    ),
  );
}
// End Top Box

//Middle Texts
Widget texts() {
  return Column(children: [
    SizedBox(height: 30),
    Text(
      "Read More about your mood in the \"Analytics\" Page",
      textAlign: TextAlign.left,
      style: GoogleFonts.lato(
        color: Colors.black54,
        fontWeight: FontWeight.w900,
        fontSize: 18,
      ),
    ),
    SizedBox(height: 20),
    Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Recommendations:",
        style: GoogleFonts.lato(
          color: Colors.black,
          fontWeight: FontWeight.w900,
          fontSize: 22,
        ),
      ),
    ),
    SizedBox(height: 15),
  ]);
}

class ResultWidget extends StatelessWidget {
  // const ResultWidget({Key? key}) : super(key: key);
  var colorsList = [
    Color(0xfff9d9e2),
    Color.fromARGB(255, 132, 193, 243),
    Color.fromARGB(255, 255, 80, 95),
    Color.fromARGB(255, 208, 133, 231)
  ];
  var titleList = [
    "Songs For You",
    "Recommendatins",
    "Info About Your Mood",
    "Things You Can Do"
  ];
  var subtitleList = [
    "You Can Play This Playlist Of Songs You May Like",
    "We Recommend You To Try\n1 - Dance\n2 - Play Songs\n3 - Jump Around\n4 - Call Your Best Friend",
    "Happiness is a mental state that includes positive or pleasant emotions ranging from contentment to intense joy. It is also used in the context of life satisfaction, subjective well-being, eudaimonia, flourishing and well-being",
    "Give a Compliment\nSmile\nExcercise\nBe Grateful\nBreathe Deeply"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 60, horizontal: 15),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              welcomingUser("Mazen Mohamed"),
              firstBox(Color.fromARGB(255, 255, 80, 95)),
              texts(),

              //cards
              Container(
                width: double.infinity,
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return Container(
                      height: 200,
                      width: 200,
                      child: Card(
                        elevation: 7,
                        color: colorsList[index],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              FittedBox(
                                child: Text(titleList[index],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    )),
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 70,
                                child: SingleChildScrollView(
                                  child: Text(subtitleList[index],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                        color: Colors.black87,
                                        fontSize: 14,
                                      )),
                                ),
                              ),
                              SizedBox(height: 7),
                              Container(
                                height: 40,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: Text("Click Here",
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
