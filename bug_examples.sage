# Make sure current directory is in path.  
# That's not true while doctesting (sage -t).
if '' not in sys.path:
    sys.path = [''] + sys.path

from igp import *

def not_minimal_3(): # this was a bug
    """
    sage: logging.disable(logging.INFO); 
    sage: h = not_minimal_3()
    sage: minimality_test(h, False)
    False
    """
    return piecewise_function_from_breakpoints_and_values([0,1/5,4/5,1],[0,1/2,1,0])

def not_minimal_wrong_range():
    """
    sage: logging.disable(logging.INFO); 
    sage: h = not_minimal_wrong_range()
    sage: minimality_test(h, False)
    False
    """
    return piecewise_function_from_breakpoints_and_values([0,1/2,1], [0,2,0])

def fake_f():
    """
    sage: logging.disable(logging.INFO); 
    sage: h = fake_f()
    sage: minimality_test(h, f=4/5)
    False
    sage: minimality_test(h, f=1/5)
    False
    """
    return piecewise_function_from_breakpoints_and_values([0,1/5,3/5,4/5,1],[0,1,0,1,0])

def limits_out_of_range():                                  # plotting bug
    """
    sage: logging.disable(logging.INFO); 
    sage: h = limits_out_of_range()
    sage: minimality_test(h, False)
    False
    """
    return FastPiecewise([[singleton_interval(0), FastLinearFunction(0,0)], [open_interval(0, 1/2), FastLinearFunction(6, -1)], [closed_interval(1/2,1), FastLinearFunction(-2, 2)]], merge=False)

def chen_tricky_uncovered_intervals():
    """
    sage: logging.disable(logging.INFO); 
    sage: h = chen_tricky_uncovered_intervals()
    sage: extremality_test(h, False)
    False
    """
    return chen_3_slope_not_extreme(f=1/sqrt(3), lam=10)    

def minimal_no_covered_interval():
    """
    sage: logging.disable(logging.WARN) 
    sage: h = minimal_no_covered_interval()
    sage: extremality_test(h, False)
    False
    """
    return FastPiecewise([[singleton_interval(0), FastLinearFunction(0, 0)], \
                          [open_interval(0, 1/2), FastLinearFunction(0, 1/2)], \
                          [singleton_interval(1/2), FastLinearFunction(0, 1)], \
                          [open_interval(1/2, 1), FastLinearFunction(0, 1/2)], \
                          [singleton_interval(1), FastLinearFunction(0, 0)]], merge=True)

def minimal_has_uncovered_interval():
    """
    sage: logging.disable(logging.WARN)
    sage: h = minimal_has_uncovered_interval()
    sage: extremality_test(h, False)
    False
    sage: simple_finite_dimensional_extremality_test(h, oversampling=4)
    False
    """
    return FastPiecewise([[singleton_interval(0), FastLinearFunction(0, 0)], \
                          [open_interval(0, 1/8), FastLinearFunction(0, 3/4)],\
                          [singleton_interval(1/8), FastLinearFunction(0, 1/2)], \
                          [open_interval(1/8, 1/4), FastLinearFunction(0, 1/4)], \
                          [singleton_interval(1/4), FastLinearFunction(0, 1)], \
                          [open_interval(1/4, 1), FastLinearFunction(0, 1/2)], \
                          [singleton_interval(1), FastLinearFunction(0,0)]], merge=True)

def lift_of_minimal_has_uncovered_interval():
    """
    This function was obtained by:
    sage_input(lift(minimal_has_uncovered_interval()))

    The function has 3 slopes and discontinuities.

    sage: logging.disable(logging.WARN)
    sage: h = lift_of_minimal_has_uncovered_interval()
    sage: len(generate_covered_intervals(h) + generate_uncovered_intervals(h)) >= 2
    True
    """
    return FastPiecewise([[singleton_interval(QQ(0)), FastLinearFunction(QQ(0), QQ(0))], [open_interval(0, 1/8), FastLinearFunction(QQ(0), 3/4)], [singleton_interval(1/8), FastLinearFunction(QQ(0), 1/2)], [open_interval(1/8, 1/4), FastLinearFunction(QQ(0), 1/4)], [singleton_interval(1/4), FastLinearFunction(QQ(0), QQ(1))], [left_open_interval(1/4, 1/2), FastLinearFunction(QQ(0), 1/2)], [left_open_interval(1/2, 9/16), FastLinearFunction(QQ(4), -3/2)], [left_open_interval(9/16, 11/16), FastLinearFunction(-QQ(4), QQ(3))], [left_open_interval(11/16, 3/4), FastLinearFunction(QQ(4), -5/2)], [open_interval(3/4, 1), FastLinearFunction(QQ(0), 1/2)], [singleton_interval(1), FastLinearFunction(QQ(0), QQ(0))]])

def lift_of_minimal_no_covered_interval():
    """
    sage: logging.disable(logging.WARN)
    sage: h = lift_of_minimal_no_covered_interval()
    sage: extremality_test(h)
    False
    """
    return FastPiecewise([[singleton_interval(QQ(0)), FastLinearFunction(-QQ(2), QQ(0))], [left_open_interval(0, 1/16), FastLinearFunction(-QQ(2), 1/2)], [left_open_interval(1/16, 3/32), FastLinearFunction(QQ(10), -1/4)], [left_open_interval(3/32, 1/8), FastLinearFunction(-QQ(14), QQ(2))], [left_open_interval(1/8, 3/8), FastLinearFunction(QQ(2), QQ(0))], [left_open_interval(3/8, 13/32), FastLinearFunction(-QQ(14), QQ(6))], [left_open_interval(13/32, 7/16), FastLinearFunction(QQ(10), -15/4)], [open_interval(7/16, 1/2), FastLinearFunction(-QQ(2), 3/2)], [singleton_interval(1/2), FastLinearFunction(-QQ(2), QQ(2))], [left_open_interval(1/2, 5/8), FastLinearFunction(QQ(2), -1/2)], [left_open_interval(5/8, 7/8), FastLinearFunction(-QQ(2), QQ(2))], [open_interval(7/8, 1), FastLinearFunction(QQ(2), -3/2)], [singleton_interval(1), FastLinearFunction(QQ(2), -QQ(2))]])

def example7slopecoarse2():
    """
    sage: logging.disable(logging.INFO); 
    sage: h = example7slopecoarse2()
    sage: extremality_test(h, False)
    False
    """
    bkpt = [0, 1/24, 1/12, 1/8, 1/6, 5/24, 7/24, 1/3, 3/8, 5/12, 11/24, 1/2, \
            13/24, 7/12, 5/8, 2/3, 5/6, 7/8, 11/12, 23/24, 1]
    values = [0, 3/4, 1/4, 3/4, 1/2, 3/4, 1/4, 1/2, 1/4, 3/4, 1/4, 1, \
              1/4, 1/2, 1/4, 1/2, 1/2, 3/4, 1/2, 3/4, 0]
    return piecewise_function_from_breakpoints_and_values(bkpt, values)

def example7slopecoarse2_lifted():
    """
    obtained via: 
    h = example7slopecoarse2(); lift_until_extreme(h, finite_dimensional_test_first=True); 
    hl = last_lifted(h).

    sage: logging.disable(logging.INFO)
    sage: h = example7slopecoarse2_lifted()
    sage: extremality_test(h, False)
    False
    """
    return FastPiecewise([[(QQ(0), 1/24), FastLinearFunction(QQ(18), QQ(0))], [left_open_interval(1/24, 1/16), FastLinearFunction(-QQ(6), QQ(1))], [left_open_interval(1/16, 1/12), FastLinearFunction(-QQ(18), 7/4)], [left_open_interval(1/12, 5/48), FastLinearFunction(QQ(18), -5/4)], [left_open_interval(5/48, 1/8), FastLinearFunction(QQ(6), QQ(0))], [left_open_interval(1/8, 1/6), FastLinearFunction(-QQ(6), 3/2)], [left_open_interval(1/6, 5/24), FastLinearFunction(QQ(6), -1/2)], [left_open_interval(5/24, 7/24), FastLinearFunction(-QQ(6), QQ(2))], [left_open_interval(7/24, 1/3), FastLinearFunction(QQ(6), -3/2)], [left_open_interval(1/3, 3/8), FastLinearFunction(-QQ(6), 5/2)], [left_open_interval(3/8, 19/48), FastLinearFunction(QQ(6), -QQ(2))], [left_open_interval(19/48, 5/12), FastLinearFunction(QQ(18), -27/4)], [left_open_interval(5/12, 7/16), FastLinearFunction(-QQ(18), 33/4)], [left_open_interval(7/16, 11/24), FastLinearFunction(-QQ(6), QQ(3))], [left_open_interval(11/24, 1/2), FastLinearFunction(QQ(18), -QQ(8))], [left_open_interval(1/2, 13/24), FastLinearFunction(-QQ(18), QQ(10))], [left_open_interval(13/24, 7/12), FastLinearFunction(QQ(6), -QQ(3))], [left_open_interval(7/12, 5/8), FastLinearFunction(-QQ(6), QQ(4))], [left_open_interval(5/8, 2/3), FastLinearFunction(QQ(6), -7/2)], [left_open_interval(2/3, 5/6), FastLinearFunction(QQ(0), 1/2)], [left_open_interval(5/6, 7/8), FastLinearFunction(QQ(6), -9/2)], [left_open_interval(7/8, 11/12), FastLinearFunction(-QQ(6), QQ(6))], [left_open_interval(11/12, 23/24), FastLinearFunction(QQ(6), -QQ(5))], [left_open_interval(23/24, QQ(1)), FastLinearFunction(-QQ(18), QQ(18))]])

def gmic_disjoint(f=4/5):
    """
    sage: logging.disable(logging.INFO)             # Suppress output in automatic tests.
    sage: h = gmic_disjoint(4/5)
    sage: extremality_test(h, False)
    True
    """        
    pieces = [[right_open_interval(0, f), FastLinearFunction(1/f, 0)],
              [[f, 1], FastLinearFunction(-1/(1-f), 1/(1-f))]]
    return FastPiecewise(pieces, merge=False)

def gmic_disjoint_with_singletons(f=4/5):
    """
    sage: logging.disable(logging.INFO)             # Suppress output in automatic tests.
    sage: h = gmic_disjoint_with_singletons(4/5)
    sage: extremality_test(h, False)
    True
    """        
    pieces = [singleton_piece(0, 0), 
              [open_interval(0, f), FastLinearFunction(1/f, 0)],
              [right_open_interval(f, 1), FastLinearFunction(-1/(1-f), 1/(1-f))],
              singleton_piece(1, 0)]
    return FastPiecewise(pieces, merge=False)

def bhk_raises_plotting_error():
    """
    There were some problems when plotting the 2d-diagram of functions having
    irrational data coerced into a (non-quadratic) RealNumberField.

    This was a plotting regression introduced by plotting function and shadows
    at the borders of 2d diagrams.

    TESTS::
    
        sage: logging.disable(logging.INFO)             # Suppress output in automatic tests.
        sage: h = bhk_raises_plotting_error()
        sage: g = plot_2d_diagram(h)
    """
    ## sage: extremality_test(h,True)
    ## ...
    ## verbose 0 (2716: plot.py, generate_plot_points) WARNING: When plotting,
    ## failed to evaluate function at 200 points.
    ## verbose 0 (2716: plot.py, generate_plot_points) Last error message:
    ## 'unsupported operand parent(s) for '-': 'Number Field in a with defining
    ## polynomial y^4 - 4*y^2 + 1' and '<type 'float'>''
    ## ...
    ## TypeError: unsupported operand parent(s) for '+': 'Number Field in a
    ## with defining polynomial y^4 - 4*y^2 + 1' and 'Real Field with 53 bits
    ## of precision'

    ## The problems concern some strange behaviors of RealNumberField_absolute
    ## sage: [x]=nice_field_values([2^(1/3)])
    ## INFO: ... Coerced into real number field: Number
    ## Field in a with defining polynomial y^3 - 2
    ## sage: x+float(1)
    ## TypeError: unsupported operand parent(s) for '+': 'Number Field in a
    ## with defining polynomial y^3 - 2' and '<type 'float'>'
    ## sage: x+RealField(53)(1)
    ## TypeError: unsupported operand parent(s) for '+': 'Number Field in a
    ## with defining polynomial y^3 - 2' and 'Real Field with 53 bits of precision'
    ## sage: RR(x)
    ## RuntimeError: maximum recursion depth exceeded while calling a Python object
    
    ## The following operations work for RealNumberField_absolute
    ## sage: x+RealIntervalField(53)(1)
    ## 2.259921049894873?
    ## sage: x+1
    ## RNF2.259921049894873?
    ## sage: x+1/10
    ## RNF1.359921049894873?
    
    ## When dealing with RealNumberField_quadratic, everything works well.
    ## sage: [y]=nice_field_values([2^(1/2)])
    ## INFO: ... Coerced into real number field: Number
    ## Field in a with defining polynomial y^2 - 2
    ## sage: y+float(1)
    ## 2.414213562373095

    ## Related issues:
    ## sage: K.<s> = NumberField(x^2 - 2)
    ## These operations give error: sage: s+float(1); s+RealField(53)(1); RR(s)

    ## If we define
    ## sage: K.<s> = QuadraticField(2)
    ## or
    ## sage: K.<s> = NumberField(x^2 - 2, embedding=1.4)
    ## then everything goes well.

    ## However,
    ## sage: K.<s> = NumberField(x^2 - 2, embedding=RIF(1.4))
    ## ValueError: 1.4000000000000000? is not a root of the defining polynomial
    ## of Number Field in s with defining polynomial x^2 - 2
    return bhk_irrational(f=4/5, d1=3/5, d2=1/10, a0=15/100, delta=(1/200, sqrt(2)/200, sqrt(3)/200), field=None)

def minimal_has_uncovered_breakpoints():
    """
    sage: logging.disable(logging.INFO)
    sage: h = minimal_has_uncovered_breakpoints()
    sage: finite_dimensional_extremality_test(h,show_all_perturbations = True)
    False
    sage: len(h._perturbations)
    3

    ..NOTE:
    If symbolic function were defined as a piecewise linear function with endpoints of \{covered_intervals\} being its breakpoints,
    then finite_dimensional_extremality_test(h,show_all_perturbations = True)
    would find a solution space that only has dimension 1,
    The finite dimensional perturbation \bar\pi_{\T} would be
    [<FastPiecewise with 4 parts,
    (0, 1/9) <FastLinearFunction x> values: [0, 1/9]
    (1/9, 7/9) <FastLinearFunction -1/3*x + 4/27> values: [1/9, -1/9]
    (7/9, 8/9) <FastLinearFunction x - 8/9> values: [-1/9, 0]
    (8/9, 1) <FastLinearFunction 0> values: [0, 0]>]
    Any equivariant perturbation \bar\pi_{\text{zero}(\T)} vanishes at breakpoint of h.
    Thus, any perturbation \bar\pi generated by extremality_test(h,show_all_perturbations = True) would satisfy \bar\pi(1/3) = (1/3)*\bar\pi(1/9).
    However this does not cover the entire perturbation space, since perturbtions \bar\pi such as
    <FastPiecewise with 5 parts,
    (0, 2/9) <FastLinearFunction 0> values: [0, 0]
    (2/9, 1/3) <FastLinearFunction x - 2/9> values: [0, 1/9]
    (1/3, 5/9) <FastLinearFunction -x + 4/9> values: [1/9, -1/9]
    (5/9, 2/3) <FastLinearFunction x - 2/3> values: [-1/9, 0]
    (2/3, 1) <FastLinearFunction 0> values: [0, 0]>
    where \bar\pi(1/3) \neq (1/3)*\bar\pi(1/9) will be missing.
    """
    bkpts = [0, 1/9, 2/9, 3/9, 5/9, 6/9, 7/9, 8/9, 1]
    values = [0, 5/8, 5/8, 4/8, 4/8, 3/8, 3/8, 1, 0]
    h = piecewise_function_from_breakpoints_and_values(bkpts, values)
    return h

def bhk_discontinuous_not_extreme_crazy_dense_move(f=4/5, d1=3/5, d2=7/110*sqrt(2), a0=15/100, field=None):
    """
    This function is two-sided discontinuous at the origin.
    Extremality test predicts it's extreme, but in fact it is not extreme,
    because crazy fat perturbation \tilde\pi can exist on the two
    horizontal slopes where moves are dense by the Strip Lemma.

    EXAMPLE:
    sage: logging.disable(logging.INFO)
    sage: h =  bhk_discontinuous_not_extreme_crazy_dense_move()
    sage: extremality_test(h) # not tested
    False
    sage: plot_with_colored_slopes(h).show(figsize=20) #not tested
    sage: plot_2d_diagram(h).show(figsize=40) #not tested
    """
    if not field:
        [f, d1, d2, a0] = nice_field_values([f, d1, d2, a0])
        rnf = f.parent().fraction_field()
    else:
        rnf = field
    d3 = f - d1 - d2
    c2 = rnf(0)
    c3 = -rnf(1)/(1-f)
    c1 = (1-d2*c2-d3*c3)/d1
    d21 = d2 / 2
    d31 = c1 / (c1 - c3) * d21
    d11 = a0 - d31
    d13 = a0 - d21
    d12 = (d1 - d13)/2 - d11
    d32 = d3/2 - d31
    b = d31
    delta0 = b * c1 / (c1 - c3)
    delta1 = b - delta0
    zigzag_lengths = []
    zigzag_slopes = []
    delta_positive = 0
    delta_negative = 0
    for delta_i in [delta0, delta1]:
        delta_i_negative = c1 * delta_i / (c1 - c3)
        delta_i_positive = delta_i - delta_i_negative
        delta_positive += delta_i_positive
        delta_negative += delta_i_negative
        zigzag_lengths = zigzag_lengths + [delta_i_positive, delta_i_negative]
        zigzag_slopes = zigzag_slopes + [c1, c3]
        d12new = d12 - delta_positive - b
        d32new = d32 - delta_negative
    slopes_left = [c3,c1,c3] + zigzag_slopes+[c1,c3]+zigzag_slopes + [c1,c3,c2]
    slopes = slopes_left + [c1] + slopes_left[::-1] + [c1,c3,c1]
    intervals_left = [b,d11-b,d31-b] + zigzag_lengths + [b-delta_positive, b-delta_negative] + zigzag_lengths + [d12new,d32new,d21]
    interval_lengths = intervals_left + [d13] + intervals_left[::-1] + [b,1-f-2*b,b]
    h_pwl = piecewise_function_from_interval_lengths_and_slopes(interval_lengths, slopes, field=rnf)
    j = b*(c1-c3)
    ymove = d11*c1+d31*c3
    xmove = [a0, a0+delta0, a0+delta0+delta1]
    disc_pts =  [rnf(0),b]+ xmove + [f-x for x in xmove[::-1]] + [f-b, f, f+b, rnf(1)-b, rnf(1)]
    disc_j = [-j, j] + [ymove-h_pwl(x)-j for x in xmove] + [-(ymove-h_pwl(x)-j) for x in xmove[::-1]] + [-j, j, -j, j, -j]
    discp = []
    for i in range(len(disc_pts)-1):
        discp.append(singleton_piece(disc_pts[i],j+disc_j[i]))
        discp.append(open_piece((disc_pts[i],j), (disc_pts[i+1],j)))
    discp.append(singleton_piece(disc_pts[-1], j+disc_j[-1]))
    h_shift = FastPiecewise(discp)
    h_raw = h_pwl+h_shift
    # expect: finite dimensional test finds perturbation space has dimension 2.
    logging.info("Try lifting the function until extreme.")
    logging.disable(logging.INFO)
    h_lift = lift_until_extreme(h_raw) # expect to lift twice
    logging.disable(logging.NOTSET)
    # return a new function
    h = FastPiecewise(zip(h_lift.intervals(), h_lift.functions()))
    return h
