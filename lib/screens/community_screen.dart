import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<User?>? _authSub;

  @override
  void initState() {
    super.initState();
    _authSub = _auth.authStateChanges().listen((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final isAnonymous = user == null || user.isAnonymous;

    return Scaffold(
      appBar: AppBar(
        title: Text('Comunidad',
            style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: isAnonymous ? _AuthView() : _FeedView(),
    );
  }
}

// ─────────────── Auth View ───────────────

class _AuthView extends StatefulWidget {
  @override
  State<_AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<_AuthView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    if (email.isEmpty || pass.length < 6) {
      _snack('Correo y contraseña (mín 6 caracteres)');
      return;
    }
    setState(() => _loading = true);
    try {
      if (_tabCtrl.index == 0) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass,
        );
      } else {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: pass,
        );
      }
    } on FirebaseAuthException catch (e) {
      _snack(e.message ?? 'Error de autenticación');
    } catch (e) {
      _snack('Error: $e');
    }
    if (mounted) setState(() => _loading = false);
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.people_rounded,
                size: 64, color: AppColors.emerald400),
            const SizedBox(height: 12),
            Text('Comunidad VIDA',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.emerald800)),
            const SizedBox(height: 4),
            Text('Comparte y conecta con otros creyentes',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: AppColors.emerald500)),
            const SizedBox(height: 28),
            Container(
              decoration: BoxDecoration(
                color: AppColors.emerald50,
                borderRadius: BorderRadius.circular(14),
              ),
              child: TabBar(
                controller: _tabCtrl,
                indicator: BoxDecoration(
                  color: AppColors.emerald600,
                  borderRadius: BorderRadius.circular(12),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.emerald600,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'Iniciar sesión'),
                  Tab(text: 'Registrarse'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: AppColors.emerald200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: AppColors.emerald200),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _passCtrl,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: AppColors.emerald200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: AppColors.emerald200),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscure
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      size: 20),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: _loading ? null : _submit,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.emerald600,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: _loading
                    ? SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : Text(
                        _tabCtrl.index == 0 ? 'Iniciar sesión' : 'Registrarse',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────── Feed View ───────────────

class _FeedView extends StatefulWidget {
  @override
  State<_FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<_FeedView> {
  final _postCtrl = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _postCtrl.dispose();
    super.dispose();
  }

  String _authorName() {
    final email = _auth.currentUser?.email ?? '';
    return email.split('@').first;
  }

  Future<void> _createPost() async {
    final content = _postCtrl.text.trim();
    if (content.isEmpty) return;
    final user = _auth.currentUser;
    if (user == null) return;

    await _db.collection('community_posts').add({
      'userId': user.uid,
      'authorName': _authorName(),
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
      'likeCount': 0,
      'likedBy': [],
    });
    _postCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: TextField(
            controller: _postCtrl,
            maxLines: 3,
            maxLength: 2000,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.send,
            onSubmitted: (_) => _createPost(),
            decoration: InputDecoration(
              hintText: 'Comparte algo con la comunidad…',
              hintStyle: TextStyle(
                  fontSize: 13, color: AppColors.emerald300),
              filled: true,
              fillColor: AppColors.emerald50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.fromLTRB(16, 12, 48, 12),
              counterStyle: TextStyle(
                  fontSize: 10, color: AppColors.emerald300),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: IconButton(
                  onPressed: _createPost,
                  icon: Icon(Icons.send_rounded, size: 20, color: AppColors.emerald600),
                ),
              ),
          ),
        ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _db
                .collection('community_posts')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snap) {
              if (snap.hasError) {
                return Center(
                  child: Text('Error al cargar',
                      style: TextStyle(color: AppColors.emerald500)),
                );
              }
              if (!snap.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                      color: AppColors.emerald600),
                );
              }
              final posts = snap.data!.docs;
              if (posts.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.forum_rounded,
                          size: 56, color: AppColors.emerald300),
                      SizedBox(height: 12),
                      Text('Sé el primero en publicar',
                          style: TextStyle(
                              fontSize: 14, color: AppColors.emerald500)),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                itemCount: posts.length,
                itemBuilder: (context, i) =>
                    _PostCard(postDoc: posts[i]),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─────────────── Post Card ───────────────

class _PostCard extends StatefulWidget {
  final QueryDocumentSnapshot postDoc;
  const _PostCard({required this.postDoc});

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  bool _showComments = false;
  final _commentCtrl = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  Map<String, dynamic> get _data =>
      widget.postDoc.data() as Map<String, dynamic>;

  bool get _isLiked {
    final likedBy = _data['likedBy'] as List<dynamic>? ?? [];
    final uid = _auth.currentUser?.uid;
    return uid != null && likedBy.contains(uid);
  }

  String _formatDate(Timestamp? ts) {
    if (ts == null) return '';
    final d = ts.toDate();
    final now = DateTime.now();
    final diff = now.difference(d);
    if (diff.inMinutes < 1) return 'Justo ahora';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${d.day}/${d.month}/${d.year}';
  }

  Future<void> _toggleLike() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;
    final ref =
        _db.collection('community_posts').doc(widget.postDoc.id);
    if (_isLiked) {
      await ref.update({
        'likedBy': FieldValue.arrayRemove([uid]),
        'likeCount': FieldValue.increment(-1),
      });
    } else {
      await ref.update({
        'likedBy': FieldValue.arrayUnion([uid]),
        'likeCount': FieldValue.increment(1),
      });
    }
  }

  Future<void> _addComment() async {
    final content = _commentCtrl.text.trim();
    if (content.isEmpty) return;
    final user = _auth.currentUser;
    if (user == null) return;

    await _db
        .collection('community_posts')
        .doc(widget.postDoc.id)
        .collection('comments')
        .add({
      'userId': user.uid,
      'authorName': user.email?.split('@').first ?? '',
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    });
    _commentCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final likeCount = _data['likeCount'] as int? ?? 0;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: AppColors.emerald100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.emerald200,
                  child: Text(
                    (_data['authorName'] as String? ?? '?')[0]
                        .toUpperCase(),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.emerald700),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_data['authorName'] ?? '',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.emerald800)),
                      Text(
                        _formatDate(
                            _data['createdAt'] as Timestamp?),
                        style: TextStyle(
                            fontSize: 11, color: AppColors.emerald400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(_data['content'] ?? '',
                style: TextStyle(
                    fontSize: 14,
                    height: 1.45,
                    color: AppColors.emerald900)),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed: _toggleLike,
                  icon: Icon(
                    _isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    size: 20,
                    color: _isLiked
                        ? Colors.redAccent
                        : AppColors.emerald500,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                Text('$likeCount',
                    style: TextStyle(
                        fontSize: 13, color: AppColors.emerald600)),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () =>
                      setState(() => _showComments = !_showComments),
                  icon: Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 20,
                    color: AppColors.emerald500,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
                // Comment count (from stream, simplified)
                Text('',
                    style: TextStyle(
                        fontSize: 13, color: AppColors.emerald600)),
              ],
            ),
            if (_showComments) ...[
              const Divider(height: 1),
              _CommentsList(postId: widget.postDoc.id),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentCtrl,
                      maxLines: 2,
                      maxLength: 500,
                      textCapitalization:
                          TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'Escribe un comentario…',
                        hintStyle: TextStyle(
                            fontSize: 12, color: AppColors.emerald300),
                        filled: true,
                        fillColor: AppColors.emerald50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        counterStyle: TextStyle(
                            fontSize: 9, color: AppColors.emerald300),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  IconButton(
                    onPressed: _addComment,
                    icon: Icon(Icons.send_rounded,
                        size: 18, color: AppColors.emerald600),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────── Comments List ───────────────

class _CommentsList extends StatelessWidget {
  final String postId;
  const _CommentsList({required this.postId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('community_posts')
          .doc(postId)
          .collection('comments')
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const SizedBox.shrink();
        final comments = snap.data!.docs;
        if (comments.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Sin comentarios',
                style:
                    TextStyle(fontSize: 12, color: AppColors.emerald400)),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(top: 8),
          itemCount: comments.length,
          separatorBuilder: (_, __) => const SizedBox(height: 6),
          itemBuilder: (context, i) {
            final c = comments[i].data() as Map<String, dynamic>;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${c['authorName'] ?? ''}: ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.emerald700),
                ),
                Expanded(
                  child: Text(c['content'] ?? '',
                      style: TextStyle(
                          fontSize: 12, color: AppColors.emerald800)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
