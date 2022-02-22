
resource "aws_lambda_function" "ProcessKinesisRecords" {

  filename      = "../lambda.zip"
  function_name = "ProcessKinesisRecords"
  role          = aws_iam_role.lambda-kinesis-role.arn

  handler       = "index.handler"

  layers        = [aws_lambda_layer_version.lambda_layer.arn]

  source_code_hash = filebase64sha256("../lambda.zip")

  runtime = "nodejs12.x"

}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "../layer.zip"
  layer_name = "lambda_layer"

  compatible_runtimes = ["nodejs12.x"]
}


resource "aws_lambda_event_source_mapping" "kinesis_lambda_event_mapping" {
    batch_size = 100
    event_source_arn = aws_kinesis_stream.lambda-stream.arn
    enabled = true
    function_name = aws_lambda_function.ProcessKinesisRecords.arn
    starting_position = "TRIM_HORIZON"
}


resource "aws_lambda_function" "ApiLambda" {

  filename      = "../api-code.zip"
  function_name = "ApiLambda"
  role          = aws_iam_role.lambda-kinesis-role.arn

  handler       = "index.handler"

  layers        = [aws_lambda_layer_version.lambda_layer.arn]

  source_code_hash = filebase64sha256("../api-code.zip")

  runtime = "nodejs12.x"

}

resource "aws_apigatewayv2_api" "api-http" {
  name          = "api-http"
  protocol_type = "HTTP"
  target        = aws_lambda_function.ApiLambda.arn

}





