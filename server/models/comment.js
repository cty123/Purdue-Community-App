const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let commentSchema = new mongoose.Schema({
    user: {
        type: Schema.Types.ObjectId, ref: 'User',
        require: true,
    },
    content: {
        type: String, 
        require: true,
    },
    post: {
        type: Schema.Types.ObjectId, ref: 'Post',
        require: true
    },
    date: {
        type: Date,
        require: false,
        default: new Date()
    }
});

module.exports = mongoose.model('Comment', commentSchema);