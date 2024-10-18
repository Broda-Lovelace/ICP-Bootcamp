import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Bool "mo:base/Bool";

actor {
  type checkFunc = (Nat, Text) -> Bool;

  public query func returnText(n1 : Nat) : async Text {
      let numberVariable = n1;
      let result = numberVariable < 2;
      if (result == true){
        return "n1 is less than 2";
      };
      else {
        return "n1 is greater than 2"
      };
  };
};
