import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final List<Map<String, String>> messages = [];

  Future<String> isArtPromptAPI(String prompt) async {
    return await chatGPTAPI(prompt);
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      print(prompt);
      final res = await http.post(
        Uri.parse('http://34.69.190.172/api/query/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "query": prompt,
        }),
      );

      if (res.statusCode == 200) {
        final Map<String, dynamic> responseBody =
            jsonDecode(res.body)['response'];
        print("bodyyyyyyy");
        print(responseBody['response']);
        if (responseBody != null &&
            responseBody['choices'] != null &&
            responseBody['choices'].isNotEmpty) {
          String content = responseBody['choices'][0]['message']['content'];
          content = content.trim();

          messages.add({
            'role': 'assistant',
            'content': content,
          });
          return content;
        } else {
          return 'Error: Invalid response structure';
        }
      } else {
        return 'Error: ${res.statusCode} - ${res.reasonPhrase}';
      }
    } catch (e) {
      return 'Error: ${e.toString()}';
    }
  }
}
