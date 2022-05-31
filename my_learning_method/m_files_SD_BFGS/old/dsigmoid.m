function h = dsigmoid(z)

h = sigmoid(z) .* (1 - sigmoid(z));
