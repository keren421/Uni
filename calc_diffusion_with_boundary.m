x0 = 0.5*(x_cells(i_x) + x_cells(i_x+1));
N0 = 0.5*erfc(-x0/sqrt(4*D*dt));
N1 = 0.5*erfc(x0/sqrt(4*D*dt));
U = rand();
    V = rand();
    if (U<N0)
        x_new = x0 + sqrt(4*D*dt)*erfcinv(V*2*N0);
    else
        x_new = -x0 + sqrt(4*D*dt)*erfcinv(V*2*N1);
    end
    i_new = ceil(x_new/dx)
    cells(i_new,i_t) = cells(i_new,i_t) + 1;