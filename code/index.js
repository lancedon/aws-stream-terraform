console.log('Loading function');
const kinesis = require('./kinesis');

exports.handler = function(event, context) {
    var key;
    
    event.Records.every(function(record) {
        // Kinesis data is base64 encoded so decode here
        var payload = Buffer.from(record.kinesis.data, 'base64').toString('ascii');
        
        try {
            payload = JSON.parse(payload);
        } catch (e) {
            console.log("Error, is not a JSON");
            return false;
        }
        
        // user_timespent > 0 
        if(payload.user_timespent > 0){
            console.log("user_timespent > 0");
            // send to stream lambda-stream-2
            kinesis.save(payload);   
        }else{
        
            console.log("user_timespent <= 0");
        }
        
    });
};
