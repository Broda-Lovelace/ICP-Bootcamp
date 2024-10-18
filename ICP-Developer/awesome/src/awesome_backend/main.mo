import Text "mo:base/Text";

actor quizTest{
  let question1 : Text = "What is the full meaning of ICP?";
  var answers : Text = "";
  let answer1 = "Internet Computer";

  public func loadquestion1() : async Text{
    return question1;
  };
  public query func enterAnswer(takeanswer1 : Text) : async Text {
    answers := takeanswer1;
    if(answers == answer1) {
       return "You are correct";
    } else {
       return "You are wrong";
    };
  };
};
