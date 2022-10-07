using FdeSolver
using Plots

## inputs
tSpan = [0, 1]     # [intial time, final time]
y0 = 1             # intial value
β = 0.6            # order of the derivative

h=2^(-5)
λ = -10
par = λ
F(t, y, par)= par * y
JF(t, y, par) = par

## Numerical solution
t,y = FDEsolver(F, tSpan, y0, β, par,h=h)
t_J, y_J = FDEsolver(F, tSpan, y0, β, par, JF = JF,h=h)

# using MittagLeffler # for the exact solution

plot(t, y, linewidth = 5, title = "Solution to a linear fractional equation",
    xaxis = "Time (t)", yaxis = "y(t)", ls = :dot, label = "Approximation")
plot!(t, t -> mittleff(β, λ * t .^ β), linewidth = 5, label = "Exact solution")
plot!(t_J, y_J, linewidth = 5, ls = :dash, label = "Approximation with jacobian")
