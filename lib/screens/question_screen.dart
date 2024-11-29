import 'package:flutter/material.dart';
import 'package:quizzy/models/question_model.dart';
import 'package:quizzy/screens/home_screen.dart';
import '../constants.dart';
import '../widgets/question_widget.dart';
import '../widgets/next_button.dart';
import '../widgets/option_card.dart';
import '../widgets/result_box.dart';
import '../models/db_connect.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // create an object for DBConnect
  var db = DBconnect();
  // List<Question> _question = [
  //   Question(
  //       id: '1',
  //       title: 'Apa framework yang digunakan untuk bahasa pemograman dart?',
  //       options: {'Flutter': true, 'Node JS': false, 'Laravel': false}),
  //   Question(id: '2', title: 'Kepanjangan dari HTML adalah?', options: {
  //     'Hyperlink Mobile Language': false,
  //     'Hyper This Mobile Lose': false,
  //     'HyperText Markup Language': true
  //   }),
  // ];
  late Future _questions;

  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

    @override
    void initState(){
      _questions = getData();
      super.initState();
    }

  // create an index to loop through _questions
  int index = 0;
  // create a score variable
  int score = 0;
  // create a boolean value to check if the user clicked
  bool isPressed = false;
  // function to display the next question
  bool isAlreadySelected = false;

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      // this is the block where the questions end
      showDialog(
          context: context,
          barrierDismissible:
              false, // this will disable the dismiss function on clicking outsite the box
          builder: (ctx) => ResultBox(
                result: score, //Total point the user got
                questionLength: questionLength,
                onPressed: () {
                  // Navigasi ke HomeScreen
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false,
                  );
                }, //out off how many questions
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++; // when the index will change to 1. rebuild the app
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Please Select Any Option.'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            return Center(child: Text('${snapshot.error}'),);
          }else if(snapshot.hasData){
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          title: const Text(
            'Quizzy Duel!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: background,
          shadowColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'Score: $score',
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // add the questionWidget here
                  QuestionWidget(
                    question: extractedData[index].title, //currently at 0
                    indexAction: index, //means the first question in the list
                    totalQuestion: extractedData.length, //total length of the list
                  ),
                  const Divider(
                    color: neutral,
                  ),
                  //Add some space
                  const SizedBox(
                    height: 25.0,
                  ),
                  for (int i = 0; i < extractedData[index].options.length; i++)
                    GestureDetector(
                      onTap: () => checkAnswerAndUpdate(
                          extractedData[index].options.values.toList()[i]),
                      child: OptionCard(
                        option: extractedData[index].options.keys.toList()[i],
                        // check the answer
                        color: isPressed
                            ? extractedData[index].options.values.toList()[i] == true
                                ? correct
                                : incorrect
                            : neutral,
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
        // floating button for next question
        floatingActionButton: GestureDetector(
          onTap: () => nextQuestion(extractedData.length),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: NextButton(
              
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
          }
        }
        else{
          return  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20.0,),
                Text('Loading euyyyy',
                style: TextStyle(
                  color: Theme.of(context).canvasColor,
                  decoration: TextDecoration.none,
                  fontSize: 22.0,
                ),)
              ],
            ),
          );
        }
        return const Center(child: Text('No Data'),
        );
      },
      
    );
  }
}
