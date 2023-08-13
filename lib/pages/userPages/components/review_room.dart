import 'package:flutter/material.dart';

class ReviewRoom extends StatelessWidget {
  const ReviewRoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '2 days ago',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 230, 0),
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 230, 0),
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 230, 0),
                      size: 16,
                    ),
                    Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 230, 0),
                      size: 16,
                    ),
                    Icon(
                      Icons.star_half,
                      color: Color.fromARGB(255, 255, 230, 0),
                      size: 16,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, diam sit amet aliquet ultricies, nisl nunc aliquam nunc, vitae aliquam nunc nisl vitae nisl. Sed euismod, diam sit amet aliquet ultricies, nisl nunc aliquam nunc, vitae aliquam nunc nisl vitae nisl.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
