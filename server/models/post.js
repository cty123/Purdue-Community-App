const mongoose = require('mongoose');
const Schema = mongoose.Schema;

let postSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true,
    },
    content: {
        type: String, 
        require: true,
    },
    user: {
        type: String,
        require: true,
    },
    comments:[
        {
            type: Schema.Types.ObjectId, 
            ref: 'Comment',
            require: false,
            default: []
        }
    ],
    date: {
        type: Date,
        require: false,
        default: new Date()
    }
});

module.exports = mongoose.model('Post', postSchema);