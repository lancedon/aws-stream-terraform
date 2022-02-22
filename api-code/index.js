console.log('Loading function');
const kinesis = require('./kinesis');

exports.handler = function(event, context, callback) {
    
    kinesis.save(event.queryStringParameters);  
    
};
