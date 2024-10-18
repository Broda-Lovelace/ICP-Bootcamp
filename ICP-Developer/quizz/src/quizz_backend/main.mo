import Text "mo:base/Text";

actor quizTest{
  let question1 : Text = "What is the full meaning of ICP?";
  let question2 : Text = "What is the default Backend Language for ICP?";
  let question3 : Text = "What year was the ICP Token Launched?";
  let question4 : Text = "Which is the first Cryptocurrency?";
  let question5 : Text = "What year was the Bitcoin launched?";
  var answers1 : Text = "";
  var answers2 : Text = "";
  var answers3 : Int = 1;
  var answers4 : Text = "";
  var answers5 : Int = 1;
  let answer1 = "Internet Computer";
  let answer2 = "Motoko";
  let answer3 = 2021;
  let answer4 = "Bitcoin";
  let answer5 = 2009;

  public func loadquestion1() : async Text{
    return question1;
  };
  public query func enterAnswer1(takeanswer1 : Text) : async Text {
    answers1 := takeanswer1;
    if(answers1 == answer1) {
       return "You are correct";
    } else {
       return "You are wrong";
    };
  };
   public func loadquestion2() : async Text{
    return question2;
  };
  public query func enterAnswer2(takeanswer2 : Text) : async Text {
    answers2 := takeanswer2;
    if(answers2 == answer2) {
       return "You are correct";
    } else {
       return "You are wrong";
    };
  };
   public func loadquestion3() : async Text{
    return question3;
  };
  public query func enterAnswer3(takeanswer3 : Int) : async Text {
    answers3 := takeanswer3;
    if(answers3 == answer3) {
       return "You are correct";
    } else {
       return "You are wrong";
    };
  };
   public func loadquestion4() : async Text{
    return question4;
  };
  public query func enterAnswer4(takeanswer4 : Text) : async Text {
    answers4 := takeanswer4;
    if(answers4 == answer4) {
       return "You are correct";
    } else {
       return "You are wrong";
    };
  };
   public func loadquestion5() : async Text{
    return question5;
  };
  public query func enterAnswer5(takeanswer5 : Int) : async Text {
    answers5 := takeanswer5;
    if(answers5 == answer5) {
       return "You are correct";
    } else {
       return "You are wrong";
    };
  };
};
