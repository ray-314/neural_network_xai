function ds = dsigmoid(h)

ds = sigmoid(h) .* (1 - sigmoid(h));
