import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../providers/news_provider.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
        actions: [
          Consumer<NewsProvider>(
            builder: (context, provider, child) {
              final isFav = provider.isFavorite(article.id);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : null,
                ),
                tooltip: isFav ? 'Remove from Favorites' : 'Add to Favorites',
                onPressed: () {
                  provider.toggleFavorite(article.id);
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Chip(
                  avatar: const Icon(Icons.tag, size: 16),
                  label: Text('Article #${article.id}'),
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                ),
                const SizedBox(width: 8),
                Chip(
                  avatar: const Icon(Icons.person, size: 16),
                  label: Text('User ID: ${article.userId}'),
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              article.body,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 24),
            Consumer<NewsProvider>(
              builder: (context, provider, child) {
                final isFav = provider.isFavorite(article.id);
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: isFav ? Colors.red.shade50 : null,
                      foregroundColor: isFav ? Colors.red : null,
                    ),
                    onPressed: () {
                      provider.toggleFavorite(article.id);
                    },
                    icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                    label: Text(
                      isFav ? 'Remove from Favorites' : 'Add to Favorites',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
