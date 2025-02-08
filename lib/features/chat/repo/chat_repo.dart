import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:learnlab/features/chat/model/chat_message_model.dart';

class ChatRepo {
  static Future<String> chatGenerateTextRepo(
      List<ChatMessageModel> previousMessage) async {
    try {
      final apiKey = dotenv.env['API_KEY'];
      Dio dio = Dio();
      final response = await dio.post(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${apiKey}",
          data: {
            "contents": previousMessage.map((e) => e.toMap()).toList(),
            "systemInstruction": {
              "role": "user",
              "parts": [
                {
                  "text":
                      "So, for this educational app , i am using gemini '\''s api . generate some sample data to fine tune the model to give response only related to the educational content. It gives the perfect roadmap for every field asked upon and every guide. Step by step mechanism and pathway. It even suggest the way of learning like if you want to learn fast. Learn through making projects and suggest projects with techstack and approach.    This education app helps students in their day to day issues."
                },
                {"text": "input: How can I become a Data Scientist?"},
                {
                  "text":
                      "output: To become a Data Scientist, follow this roadmap:Mathematics & Statistics: Learn linear algebra, probability, and statistics. Recommended resources: Khan Academy, StatQuest.Programming: Focus on Python or R. Start with Python basics, then explore libraries like NumPy, pandas, and matplotlib.Data Manipulation: Learn SQL and data wrangling techniques.Machine Learning: Study supervised/unsupervised learning, regression, and classification. Recommended courses: Andrew Ng’s ML course on Coursera.Projects: Build projects like predicting housing prices, sentiment analysis, or recommendation systems using scikit-learn.Portfolio: Document projects on GitHub and create a LinkedIn profile to showcase your work.Advanced Topics: Dive into deep learning, NLP, or big data tools like Spark, TensorFlow, and PyTorch.\nFor faster learning, focus on hands-on projects and contribute to open-source datasets on Kaggle"
                },
                {
                  "text":
                      "input: I want to learn web development quickly. What'\''s the best approach?"
                },
                {
                  "text":
                      "output: For fast-tracked web development learning:Start with Basics: Learn HTML, CSS, and JavaScript fundamentals. Resource: MDN Web Docs.Projects: Build small projects like a personal website, to-do app, or weather app.Frameworks: Move on to React for frontend, and Node.js with Express for backend.Database: Learn MongoDB for NoSQL databases.Full-Stack Projects: Create a blog platform or e-commerce site integrating frontend, backend, and database.Deployment: Use platforms like Vercel or Netlify for frontend and Heroku for backend.\nTech Stack Suggestion: React, Node.js, Express, MongoDB.\nFocus on building real-world projects, solving coding challenges on platforms like LeetCode, and contributing to GitHub repositories."
                },
                {
                  "text":
                      "input: I’m struggling to manage my time for studies. Any advice?"
                },
                {
                  "text":
                      "output: Here’s a step-by-step approach for better time management:Prioritize Tasks: Use the Eisenhower Matrix to distinguish between urgent and important tasks.Create a Study Schedule: Allocate specific time slots for each subject and stick to it.Use Tools: Tools like Google Calendar, Notion, or Todoist help in organizing your study plan.Pomodoro Technique: Study in 25-minute intervals with 5-minute breaks.Eliminate Distractions: Use apps like Forest or Focus@Will to stay focused.Review Progress: Reflect weekly on your productivity and adjust your schedule as needed."
                },
                {
                  "text":
                      "input: Suggest some projects to improve my Flutter skills."
                },
                {
                  "text":
                      "output: Here are some Flutter project ideas to level up your skills:To-Do List App: Learn state management with Provider or Riverpod.Weather App: Integrate APIs like OpenWeatherMap to fetch real-time data.Expense Tracker: Work with local databases using SQLite or Hive.Chat Application: Implement real-time messaging with Firebase.E-commerce App: Use Flutter for UI, Firebase for backend, and integrate payment gateways.\nFor each project, focus on UI/UX design, API integration, and state management to improve your expertise."
                },
                {
                  "text":
                      "input: I want to become a Machine Learning Engineer. What should I do?"
                },
                {
                  "text":
                      "output: Follow this step-by-step roadmap to become a Machine Learning Engineer:Mathematics: Focus on linear algebra, calculus, probability, and statistics.Programming: Master Python, focusing on libraries like NumPy, pandas, and matplotlib.Machine Learning Algorithms: Learn regression, classification, clustering, and decision trees. Use scikit-learn for implementation.Deep Learning: Explore neural networks with TensorFlow and PyTorch.Projects: Build projects like spam email classifiers, image recognition models, or recommendation systems.Model Deployment: Learn tools like Flask, FastAPI, or TensorFlow Serving to deploy models.Portfolio: Document your projects on GitHub and write about them on Medium or personal blogs."
                },
                {"text": "input: Guide for learning computer networks"},
                {
                  "text":
                      "output: Here'\''s your networking learning path:\\n\\n1. Fundamentals (2 months):\\n- OSI model\\n- TCP/IP protocols\\n- Subnetting basics\\n\\nPractical Project: Home Network\\n- Tech: Router, switches\\n- Setup: VLAN configuration\\n- Skills: Network security, IP management\\n\\n2. Advanced Topics (3 months):\\n- Network security\\n- Wireless protocols\\n- Cloud networking\\n\\nFast-Track Approach:\\n1. Use packet tracers\\n2. Build lab environments\\n3. Practice troubleshooting\\n\\nCertification Path:\\n- CompTIA Network+\\n- CCNA preparation\\n- Hands-on labs"
                },
                {"text": "input: How to manage multiple coding projects?"},
                {
                  "text":
                      "output: Here'\''s your project management strategy:\\n\\n1. Project Organization:\\n- Git version control\\n- Kanban board setup\\n- Time blocking technique\\n\\nImplementation Plan:\\n- Morning: Complex coding\\n- Afternoon: Reviews/debugging\\n- Evening: Planning next day\\n\\nTools Setup:\\n1. GitHub for code\\n2. Jira/Trello for tasks\\n3. Time tracking apps\\n\\nEfficiency Tips:\\n- Use code templates\\n- Automate testing\\n- Regular code reviews\\n\\nTracking Method:\\n- Daily commits\\n- Weekly sprints\\n- Monthly reviews"
                },
                {"text": "input: How to learn cloud computing?"},
                {
                  "text":
                      "output: \"Here'\''s your cloud computing pathway:\\n\\n1. Foundation (2 months):\\n- Linux basics\\n- Networking fundamentals\\n- Virtualization concepts\\n\\nFirst Project: Cloud Server\\n- Tech: AWS/Azure free tier\\n- Goal: Host web application\\n- Skills: VM management, security\\n\\n2. Core Services (3 months):\\n- Compute services\\n- Storage solutions\\n- Networking services\\n\\nFast Learning Path:\\n1. Use free tier resources\\n2. Follow cloud labs\\n3. Build mini-projects\\n\\nCertification Track:\\n- AWS Cloud Practitioner\\n- Azure Fundamentals\\n- Hands-on practice\""
                },
                {"text": "input: \"Guide for learning AI and ML\","},
                {
                  "text":
                      "output: \"Here'\''s your AI/ML learning roadmap:\\n\\n1. Prerequisites (3 months):\\n- Python programming\\n- Linear algebra\\n- Probability theory\\n\\nFirst Project: Image Classifier\\n- Tech: TensorFlow/PyTorch\\n- Dataset: MNIST/CIFAR-10\\n- Skills: Neural networks, CNN\\n\\n2. Core ML (4 months):\\n- Supervised learning\\n- Deep learning basics\\n- Model optimization\\n\\nQuick Learning Path:\\n1. Focus on implementations\\n2. Use Google Colab\\n3. Join Kaggle competitions\\n\\nProject Progress:\\n- Data preprocessing\\n- Model building\\n- Deployment basics\""
                },
                {"text": "input: \"How to improve debugging skills?\","},
                {
                  "text":
                      "output: \"Here'\''s your debugging skill enhancement plan:\\n\\n1. Basic Techniques (2 weeks):\\n- Logger implementation\\n- Debugger tools\\n- Error pattern recognition\\n\\nPractice Project: Bug Tracker\\n- Tech: VS Code debugger\\n- Focus: Systematic debugging\\n- Tools: Chrome DevTools\\n\\n2. Advanced Methods (1 month):\\n- Memory profiling\\n- Performance analysis\\n- Root cause analysis\\n\\nEfficiency Approach:\\n1. Use debugging tools daily\\n2. Document common bugs\\n3. Review fixed issues\\n\\nSkill Development:\\n- Log analysis\\n- Breakpoint strategy\\n- Performance optimization\""
                },
                {"text": "input: \"How to learn cybersecurity?\","},
                {
                  "text":
                      "output: \"Here'\''s your cybersecurity roadmap:\\n\\n1. Basics (3 months):\\n- Networking fundamentals\\n- Linux commands\\n- Security concepts\\n\\nFirst Project: Security Audit\\n- Tech: Kali Linux tools\\n- Focus: Network scanning\\n- Skills: Vulnerability assessment\\n\\n2. Core Skills (4 months):\\n- Ethical hacking\\n- Penetration testing\\n- Security protocols\\n\\nAccelerated Path:\\n1. Set up home lab\\n2. Practice CTF challenges\\n3. Study real cases\\n\\nCertification Track:\\n- CompTIA Security+\\n- CEH preparation\\n- Practical labs\""
                },
                {
                  "text":
                      "input: \"\"Guide for time management in software development\","
                },
                {
                  "text":
                      "output: \"Here'\''s your time management strategy:\\n\\n1. Daily Structure:\\n- Morning: Complex coding\\n- Afternoon: Meetings/reviews\\n- Evening: Learning/planning\\n\\nImplementation Tools:\\n- Pomodoro technique\\n- Time blocking\\n- Task prioritization\\n\\nProductivity System:\\n1. Use project boards\\n2. Set daily goals\\n3. Track time spent\\n\\nEfficiency Tips:\\n- Automate routine tasks\\n- Use code snippets\\n- Regular breaks\\n\\nProgress Tracking:\\n- Daily standups\\n- Weekly reviews\\n- Monthly assessments\""
                },
                {"text": "input: hey how can i be a app developer"},
                {"text": "output: "}
              ]
            },
            "generationConfig": {
              "temperature": 1,
              "topK": 40,
              "topP": 0.95,
              "maxOutputTokens": 8192,
              "responseMimeType": "text/plain"
            }
          });

      // if (response.statusCode! >= 200 && response.statusCode! < 300) {
      //   return response
      //       .data['candidates'].first['content']['parts'].first['text'];
      // }
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final outputText =
            response.data['candidates'].first['content']['parts'].first['text'];

        if (outputText != null) {
          print('Generated Text: $outputText');
          return outputText;
        } else {
          print('No output text found in the response.');
          return '';
        }
      }

      return '';
    } catch (e) {
      if (e is DioException) {
        print('error message : ${e.message}');
        if (e.response != null) {
          print('Error data: ${e.response?.data}');
          print('Error headers : ${e.response?.headers}');
        }
      } else {
        print('general error : ${e.toString()}');
      }

      return '';
    }
  }
}
