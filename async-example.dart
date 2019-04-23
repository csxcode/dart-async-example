import 'dart:async';

class Cake{}
class Order{
  String type;
  Order(this.type);
}

void main(){
  final controller = new StreamController();

  final order1 = new Order('chocolate');
  final order2 = new Order('vanilla');
  final order3 = new Order('chocolate');

  final baker = StreamTransformer.fromHandlers(
      handleData: (cakeType, sink){
        if(cakeType == 'chocolate'){
          sink.add(new Cake());
        }else{
          sink.addError('Cannot make this type: $cakeType');
        }
      }
  );

  controller.sink.add(order1);
  controller.sink.add(order2);
  controller.sink.add(order3);

  controller.stream
      .map((order) => order.type)
      .transform(baker)
      .listen(
          (cake) => print('Here is your cake $cake'),
      onError: (err) => print(err)
  );

}