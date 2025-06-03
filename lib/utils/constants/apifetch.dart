import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<dynamic> fetchApiWithStyledDialog({
  required BuildContext context,
  required String url,
  String method = 'GET',
  Map<String, String>? headers,
  Map<String, dynamic>? body,
  Duration timeoutDuration = const Duration(seconds: 30),
  String loadingMessage = 'Processing your request',
  bool showSuccessDialog = false,
  String successMessage = 'Operation completed successfully',
}) async {
  // Show elegant loading dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth: 3.0,
            ),
            const SizedBox(height: 20),
            Text(
              loadingMessage,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );

  try {
    // Validate URL
    if (url.isEmpty) {
      throw const FormatException('URL cannot be empty');
    }

    final uri = Uri.parse(url);
    late http.Response response;

    switch (method.toUpperCase()) {
      case 'GET':
        response = await http.get(uri, headers: headers).timeout(timeoutDuration);
        break;
      case 'POST':
        response = await http.post(
          uri,
          headers: headers,
          body: jsonEncode(body),
        ).timeout(timeoutDuration);
        break;
      case 'PUT':
        response = await http.put(
          uri,
          headers: headers,
          body: jsonEncode(body),
        ).timeout(timeoutDuration);
        break;
      case 'DELETE':
        response = await http.delete(
          uri,
          headers: headers,
          body: jsonEncode(body),
        ).timeout(timeoutDuration);
        break;
      default:
        throw FormatException('Unsupported HTTP method: $method');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Navigator.of(context).pop();

      if (showSuccessDialog) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Success',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    successMessage,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        await Future.delayed(const Duration(seconds: 1));
        if (context.mounted) Navigator.of(context).pop();
      }

      try {
        return jsonDecode(response.body);
      } catch (e) {
        return response.body;
      }
    } else {
      String errorMessage;
      try {
        final errorResponse = jsonDecode(response.body);
        errorMessage = errorResponse['message'] ??
            errorResponse['error'] ??
            'Request failed (Status: ${response.statusCode})';
      } catch (e) {
        errorMessage = 'Request failed (Status: ${response.statusCode})';
      }

      if (context.mounted) {
        Navigator.of(context).pop();
        _showStyledErrorDialog(context, errorMessage);
      }
      return null;
    }
  } on FormatException catch (e) {
    if (context.mounted) {
      Navigator.of(context).pop();
      _showStyledErrorDialog(context, 'Invalid URL: ${e.message}');
    }
    return null;
  } on http.ClientException catch (e) {
    if (context.mounted) {
      Navigator.of(context).pop();
      _showStyledErrorDialog(context, 'Network error: ${e.message}');
    }
    return null;
  } on TimeoutException catch (_) {
    if (context.mounted) {
      Navigator.of(context).pop();
      _showStyledErrorDialog(context, 'Request timed out after ${timeoutDuration.inSeconds} seconds');
    }
    return null;
  } on SocketException catch (_) {
    if (context.mounted) {
      Navigator.of(context).pop();
      _showStyledErrorDialog(context, 'No internet connection. Please check your network settings.');
    }
    return null;
  } on HandshakeException catch (_) {
    if (context.mounted) {
      Navigator.of(context).pop();
      _showStyledErrorDialog(context, 'Security error. Could not establish secure connection.');
    }
    return null;
  } on Exception catch (e) {
    if (context.mounted) {
      Navigator.of(context).pop();
      _showStyledErrorDialog(context, 'Unexpected error: ${e.toString()}');
    }
    return null;
  }
}

void _showStyledErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Error Occurred',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}