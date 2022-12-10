import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue: Float = 300;  // stable -> orthogonal persistence
  stable var startTime = Time.now();

  public func topUp(amount: Float) {  // update method -> slow
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withDraw(amount: Float) {
    let netAmount: Float = currentValue - amount;  // const

    if(netAmount >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    }
    else
      Debug.print("Amount is too large");
  };

  public query func checkBalance(): async Float {  // query method -> faster
    compoundInterest();
    return currentValue;
  };

  func compoundInterest() {
    let currentTime = Time.now();
    let timeElapseS = (currentTime - startTime) / 1000000000;

    currentValue := currentValue * (1.000001 ** Float.fromInt(timeElapseS));
    startTime := currentTime;
  };

}