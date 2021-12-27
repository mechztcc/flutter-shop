import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 4,
      ),
      child: ListTile(
        title: Text(cartItem.name),
        subtitle: Text('Total R\$ ${cartItem.price * cartItem.quantity}'),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                '${cartItem.price}',
                style: TextStyle(color: Colors.lightGreenAccent),
              ),
            ),
          ),
        ),
        trailing: Text('${cartItem.quantity}x'),
      ),
    );
  }
}
