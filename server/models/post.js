const mongoose = require('mongoose');
const Schema = mongoose.Schema;
var mongoosePaginate = require('mongoose-paginate-v2');

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
        type: Schema.Types.ObjectId, 
            ref: 'User',
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

postSchema.plugin(mongoosePaginate);
module.exports = mongoose.model('Post', postSchema);