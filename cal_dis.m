function d = cal_dis(p, q)

% normalize
p = (p - mean(p)) / std(p);
q = (q - mean(q)) / std(q);

d = min([sqrt(sum((p - q).^2)), sqrt(sum((p + q).^2))]); 
