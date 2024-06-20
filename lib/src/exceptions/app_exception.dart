import 'package:love_cooking_app/src/localization/string_hardcoded.dart';

/// Base class for all all client-side errors that can be generated by the app
sealed class AppException implements Exception {
  AppException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => message;
}

/// Auth
class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException()
      : super('email-already-in-use', 'Email already in use'.hardcoded);
}

class WeakPasswordException extends AppException {
  WeakPasswordException()
      : super('weak-password', 'Password is too weak'.hardcoded);
}

class WrongPasswordException extends AppException {
  WrongPasswordException()
      : super('wrong-password', 'Wrong password'.hardcoded);
}

class UserNotFoundException extends AppException {
  UserNotFoundException() : super('user-not-found', 'User not found'.hardcoded);
}

/// TODO correct exceptions
/// Cart
class CartSyncFailedException extends AppException {
  CartSyncFailedException()
      : super('cart-sync-failed',
            'An error has occurred while updating the shopping cart'.hardcoded);
}

/// Wishlist
class WishlistSyncFailedException extends AppException {
  WishlistSyncFailedException()
      : super('wishlist-sync-failed',
            'An error has occurred while updating the wishlist'.hardcoded);
}

/// Checkout
class PaymentFailureEmptyCartException extends AppException {
  PaymentFailureEmptyCartException()
      : super('payment-failure-empty-cart',
            'Can\'t place an order if the cart is empty'.hardcoded);
}

/// Orders
class ParseOrderFailureException extends AppException {
  ParseOrderFailureException(this.status)
      : super('parse-order-failure',
            'Could not parse order status: $status'.hardcoded);
  final String status;
}
