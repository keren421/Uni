num_generation = 300;
num_samples = 500;
num_diploid = 100;
initial_freq = 0.5;

sz = num_diploid*2;  %100 diploids -> 200 genomes
k = nan(num_samples, num_generation); %matrix to store results
k(:,1) = initial_freq;

for i = 1:num_samples
   xf = x;  %initial freq always 0.5, going fwd xf will store our updated allele freq
   for j = 1:num_generation %5 generations require 4 samples
     xf = binornd(sz,k(i,j)) / sz; %random sample, pop size 200
     k(i,j+1) = xf;   %update matrix
   end
end

%Now plot all 1000 random walks
figure(); hold all;
ylim([0,1]);
xlim([1,num_generation+1]);
xlabel('generation')
ylabel('allel freq')
for i = 1:num_samples
  hold all
  plot(1:num_generation+1, k(i,:), '-*')
end
grid on

figure(); hist(k(:,end));