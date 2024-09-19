require 'json'

def process(event:, context:)
  # fetch query params
  params = event["queryStringParameters"]
  return error("please provide points and max parameters") if params.nil?
  return error("please provide points parameter") if params["points"].nil?
  return error("please provide max parameter") if params["max"].nil?

  # convert to numbers
  max_points = params["max"].to_i
  total_points = params["points"].to_i
  
  # validate params
  return error("max must be greater than 1") if max_points <= 1
  return error("points must be greater than 1") if total_points <= 1
  return error("max must not be greater than points") if total_points > max_points
  
  # calculate
  final_grade = grade(total_points, max_points)

  # log as jsonline
  puts(JSON.generate({
    grade: final_grade,
    points: total_points,
    max: max_points
  }))

  # respond
  {
    statusCode: 200,
    body: JSON.generate({
      grade: final_grade,
      points: total_points,
      max: max_points
    })
  }
end

# format error response
def error(message)
  {
    statusCode: 422,
    body: JSON.generate({
      type: "error",
      message: message
    })
  }
end

# grading matrix
MATRIX = [
  [14.0, 5.0],
  [49.0, 4.7],
  [54.0, 4.0],
  [59.0, 3.7],
  [64.0, 3.3],
  [69.0, 3.0],
  [74.0, 2.7],
  [79.0, 2.3],
  [84.0, 2.0],
  [90.0, 1.7],
  [95.0, 1.3],
  [100.0, 1.0]
]

# grade based on max points
def grade(points, max)
  p = (points.to_f / max.to_f) * 100
  MATRIX.each do |i|
    return i[1] if p <= i[0]
  end
  nil
end 