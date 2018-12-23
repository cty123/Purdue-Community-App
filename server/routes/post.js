var express = require('express');
var router = express.Router();
const Post = require('../models/post');
const Comment = require('../models/comment');

router.get('/', async (req, res, next) => {
  // Get page from the request query
  let page = req.query.page;

  // Check if the user has specified a page
  if (!page) {
    // Perform first query to get the totalPages
    page = 1;
    
    // Perform the first query to get the total number of pages
    let response = await Post.paginate({}, {populate: 'user', page: page, limit: 2, sort: {date: 1}});

    // Assign the maxpage to the user
    page = response.totalPages;

    // Perform the second query to actually fetch the data
    let posts = await Post.paginate({}, {populate: 'user', page: page, limit: 2, sort: {date: 1}});

    // Return JSON
    res.status(201).json({
      status: 'Success',
      posts: posts.docs,
      page: posts.page,
      totalPages: posts.totalPages
    });

  } else {
    // If the user specifies a page, we simply return that page
    let posts = await Post.paginate({}, {populate: 'user', page: page, limit: 2, sort: {date: 1}});

    // Return JSON
    res.status(201).json({
      status: 'Success',
      posts: posts.docs,
      page: posts.page,
      totalPages: posts.totalPages
    });
  }
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

router.post('/edit', async (req, res, next) => {
  const {post_id, title, content} = req.body;

  // Get post by the provided id
  try {
    let post = await Post.findById(post_id).populate('user');

    // Check if the post owner is the requester
    if (!post.user._id.equals(req.user._id)) {
      res.status(200).json({
        status: 'Failed',
        message: 'Not authorized to edit this post'
      });
      return;
    }

    // Change and save the title and content
    post.title = title;
    post.content = content;
    await post.save();
    
    // Return success message
    res.status(200).json({
      status: 'Success',
      message: 'Success'
    });
  }catch(e) {
    print(e);
    res.status(200).json({
      status: 'Failed',
      message: 'Database Error'
    });
  }
});
module.exports = router;