import 'package:flutter/material.dart';

class Termos extends StatelessWidget {
  const Termos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  
                  child: Expanded(
                    child: Text(
                       'TERMOS E CONDIÇÕES'
                        , style: TextStyle(fontSize: 19, backgroundColor: Colors.white, color: Colors.red),
                        ),
                  ),
                ),
              ),
              Center(
                child: Expanded(
                  child: Text(
                      'Lorem ipsum dolor sit amet. Aut accusamus odit qui blanditiis sint et voluptatem nihil est dolore modi et suscipit fugiat non velit tenetur. Ab dolores tenetur ab autem debitis est esse Quis eos sunt voluptatem ad voluptas architecto. Id laborum minima a nostrum perferendis eum fugit sint et laudantium optio est unde veritatis?A deserunt quis rem veritatis perspiciatis aut voluptatibus modi aut distinctio consequuntur et eligendi fugit. Ab minima est quasi voluptates ab aliquid tempora et sint praesentium qui autem numquam? Non quisquam magni ut vitae totam est excepturi debitis ea quasi magni aut totam repellendus ad laborum incidunt?Eum odio nesciunt in nostrum necessitatibus eos tenetur quia! Id ipsam quos a harum minus aut enim laudantium.'
                      , style: TextStyle(fontSize: 14, backgroundColor: Colors.white),
                      ),
                ),
              ),
              Center(
                child: Expanded(
                  child: Text(
                      'Lorem ipsum dolor sit amet. Aut accusamus odit qui blanditiis sint et voluptatem nihil est dolore modi et suscipit fugiat non velit tenetur. Ab dolores tenetur ab autem debitis est esse Quis eos sunt voluptatem ad voluptas architecto. Id laborum minima a nostrum perferendis eum fugit sint et laudantium optio est unde veritatis?A deserunt quis rem veritatis perspiciatis aut voluptatibus modi aut distinctio consequuntur et eligendi fugit. Ab minima est quasi voluptates ab aliquid tempora et sint praesentium qui autem numquam? Non quisquam magni ut vitae totam est excepturi debitis ea quasi magni aut totam repellendus ad laborum incidunt?Eum odio nesciunt in nostrum necessitatibus eos tenetur quia! Id ipsam quos a harum minus aut enim laudantium.'
                      , style: TextStyle(fontSize: 14, backgroundColor: Colors.white),
                      ),
                ),
              ),
              Center(
                child: Expanded(
                  child: Text(
                      'Lorem ipsum dolor sit amet. Aut accusamus odit qui blanditiis sint et voluptatem nihil est dolore modi et suscipit fugiat non velit tenetur. Ab dolores tenetur ab autem debitis est esse Quis eos sunt voluptatem ad voluptas architecto. Id laborum minima a nostrum perferendis eum fugit sint et laudantium optio est unde veritatis?A deserunt quis rem veritatis perspiciatis aut voluptatibus modi aut distinctio consequuntur et eligendi fugit. Ab minima est quasi voluptates ab aliquid tempora et sint praesentium qui autem numquam? Non quisquam magni ut vitae totam est excepturi debitis ea quasi magni aut totam repellendus ad laborum incidunt?Eum odio nesciunt in nostrum necessitatibus eos tenetur quia! Id ipsam quos a harum minus aut enim laudantium.'
                      , style: TextStyle(fontSize: 14, backgroundColor: Colors.white),
                      ),
                ),
              ),
              Center(
                child: Expanded(
                  child: Text(
                      'Lorem ipsum dolor sit amet. Aut accusamus odit qui blanditiis sint et voluptatem nihil est dolore modi et suscipit fugiat non velit tenetur. Ab dolores tenetur ab autem debitis est esse Quis eos sunt voluptatem ad voluptas architecto. Id laborum minima a nostrum perferendis eum fugit sint et laudantium optio est unde veritatis?A deserunt quis rem veritatis perspiciatis aut voluptatibus modi aut distinctio consequuntur et eligendi fugit. Ab minima est quasi voluptates ab aliquid tempora et sint praesentium qui autem numquam? Non quisquam magni ut vitae totam est excepturi debitis ea quasi magni aut totam repellendus ad laborum incidunt?Eum odio nesciunt in nostrum necessitatibus eos tenetur quia! Id ipsam quos a harum minus aut enim laudantium.'
                      , style: TextStyle(fontSize: 14, backgroundColor: Colors.white),
                      ),
                ),
              ),
              Center(
                child: Expanded(
                  child: Text(
                      'Lorem ipsum dolor sit amet. Aut accusamus odit qui blanditiis sint et voluptatem nihil est dolore modi et suscipit fugiat non velit tenetur. Ab dolores tenetur ab autem debitis est esse Quis eos sunt voluptatem ad voluptas architecto. Id laborum minima a nostrum perferendis eum fugit sint et laudantium optio est unde veritatis?A deserunt quis rem veritatis perspiciatis aut voluptatibus modi aut distinctio consequuntur et eligendi fugit. Ab minima est quasi voluptates ab aliquid tempora et sint praesentium qui autem numquam? Non quisquam magni ut vitae totam est excepturi debitis ea quasi magni aut totam repellendus ad laborum incidunt?Eum odio nesciunt in nostrum necessitatibus eos tenetur quia! Id ipsam quos a harum minus aut enim laudantium.'
                      , style: TextStyle(fontSize: 14, backgroundColor: Colors.white),
                      ),
                ),
              ),
              Center(
                child: Expanded(
                  child: Text(
                      'Lorem ipsum dolor sit amet. Aut accusamus odit qui blanditiis sint et voluptatem nihil est dolore modi et suscipit fugiat non velit tenetur. Ab dolores tenetur ab autem debitis est esse Quis eos sunt voluptatem ad voluptas architecto. Id laborum minima a nostrum perferendis eum fugit sint et laudantium optio est unde veritatis?A deserunt quis rem veritatis perspiciatis aut voluptatibus modi aut distinctio consequuntur et eligendi fugit. Ab minima est quasi voluptates ab aliquid tempora et sint praesentium qui autem numquam? Non quisquam magni ut vitae totam est excepturi debitis ea quasi magni aut totam repellendus ad laborum incidunt?Eum odio nesciunt in nostrum necessitatibus eos tenetur quia! Id ipsam quos a harum minus aut enim laudantium.'
                      , style: TextStyle(fontSize: 14, backgroundColor: Colors.white),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(context);
                    },
                    child: Icon(Icons.arrow_back)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
