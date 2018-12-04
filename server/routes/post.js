var express = require('express');
var router = express.Router();
const Post = require('../models/post');
const Comment = require('../models/comment');

router.get('/', async (req, res, next) => {
  // Get page from the request query
  let page = req.query.page;

  // Fetch posts at that page
  let posts = await Post.paginate({}, {page: page, limit: 2, sort: {date: -1}})

  // Return posts
  res.status(201).json({
    status: 'Success',
    posts: posts.docs,
    page: postsz.page
  });
});

router.post('/', function (req, res, next) {
  const {title, content} = req.body;
  let user = req.user;

  if (!title) {
    res.json({
      status: 'Failed',
      message: 'No title'
    });
    return;
  }

  if (!content) {
    res.json({
      status: 'Failed',
      message: 'No content'
    });
    return;
  }

  let p = new Post();
  p.title = title;
  p.content = content;
  p.user = user;
  p.save();

  res.status(201).json({
    status: 'Success',
    post: p
  });
});

router.get('/comment', async (req, res, next) => {
  var {post_id, page} = req.query;

  let p = await Post.findById(post_id);

  if (!p) {
    res.json({
			status: 'Failed',
			message: 'No post found'
		});
		return;
  }

  let result = await Comment.paginate({post: post_id}, {page: page, limit: 2, sort: {date: -1}})

  res.status(201).json({
    status: 'Success',
    comments: result.docs,
    page: result.page? result.page:1
  });
});

router.post('/comment', async (req, res, next) => {
  const {post_id, content} = req.body;
	let user = req.user;
	
	if (!content) {
		res.json({
			status: 'Failed',
			message: 'No content'
		});
		return;
	}

	p = await Post.findById(post_id);

	if (!p) {
		res.json({
			status: 'Failed',
			message: 'No post found'
		});
		return;
	}

	let c = new Comment();
	c.content = content;
  c.user = user;
  c.post = p;
	c.save();

	p.comments.push(c);
	p.save();

	res.status(201).json({
		status: 'Success',
		post: c
	});
});

module.exports = router;