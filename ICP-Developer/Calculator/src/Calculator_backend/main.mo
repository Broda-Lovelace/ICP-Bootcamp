actor Calculator{
  var cell : Nat = 0;
  public func add(number : Nat) async Nat {
    cell += number;
    return cell;
  };

  public func subtract(number : Nat) async Nat {
    cell -= number;
    return cell;
  };

  public func multiply(number : Nat) async Nat {
    cell *= number;
    return cell;
  };

  public func divide(number : Nat) async Nat {
    cell /= number if(cell == 0) {
      return "Null"
    };
    return cell;
  };

};
