resource "aws_kinesis_stream" "lambda-stream" {
  name             = "lambda-stream"
  shard_count      = 1
  retention_period = 24

  shard_level_metrics = []

}

resource "aws_kinesis_stream" "lambda-stream-2" {
  name             = "lambda-stream-2"
  shard_count      = 1
  retention_period = 24

  shard_level_metrics = []
  
}