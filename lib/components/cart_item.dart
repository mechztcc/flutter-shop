import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false)
            .removeItem(cartItem.productId);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 4,
        ),
      ),
      child: Card(
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
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          trailing: Text('${cartItem.quantity}x'),
        ),
      ),
    );
  }
}
