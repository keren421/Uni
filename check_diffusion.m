results =[];
expected = [];
for i = 1:length(t)
    figure(1); clf; plot(x_cells(2:end),population1(:,i));
    pause(0.1)
     f = fit(x_cells(1:end-1)',population1(:,i),'gauss1');
     results(i) = f.c1/sqrt(2);
 end
expected = sqrt(2*eq_parm.D*t);

figure(2);hold all;
plot(results);
plot(expected);