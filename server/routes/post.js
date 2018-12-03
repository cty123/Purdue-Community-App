var express = require('express');
var router = express.Router();
const Post = require('../models/post');
const Comment = require('../models/comment');

router.get('/', async (req, res, next) => {
  let posts = await Post.find().sort('date').limit(2);
  res.status(201).json({
    status: 'Success',
    posts: posts
  });
});

router.post('/', function (req, res, next) {
  let title = req.body.title;
  let content = req.body.content;
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
  let post_id = req.query.post_id;

  let p = await Post.findById(post_id);

  if (!p) {
    res.json({
			status: 'Failed',
			message: 'No post found'
		});
		return;
  }

  let comments = await Comment.find({post: post_id}).sort('date').limit(3)

  res.status(201).json({
    status: 'Success',
    comments: comments
  });
  
});

router.post('/comment', async (req, res, next) => {
  let post_id = req.body.post_id;
	let content = req.body.content;
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