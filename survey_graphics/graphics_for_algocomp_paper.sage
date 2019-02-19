############################################################
## Other moves diagrams:
############################################################

load("survey_graphics/graphics_for_algo_paper_init.sage")

igp.show_plots_figsize = 10
paper_plot_kwds['fontsize'] = 10   # restore to sage default

## sage: moves = [ FunctionalDirectedMove([(0, 1/2^n)], (1, 1/2^n)) for n in range(1, 4) ]
## sage: DirectedMoveCompositionCompletion(moves)
## <DirectedMoveCompositionCompletion (incomplete, -1 rounds) with 3 directed moves and 0 covered components>
## sage: M = DirectedMoveCompositionCompletion(moves)
## sage: M.complete()
## INFO: 2019-01-21 19:45:06,869 Completing 6 functional directed moves and 0 covered components...
## INFO: 2019-01-21 19:45:06,884 Completing 13 functional directed moves and 0 covered components...
## INFO: 2019-01-21 19:45:06,924 Completing 15 functional directed moves and 0 covered components...
## INFO: 2019-01-21 19:45:06,947 Completing 15 functional directed moves and 0 covered components...
## INFO: 2019-01-21 19:45:06,958 Completing 15 functional directed moves and 0 covered components...
## INFO: 2019-01-21 19:45:06,967 Completion finished.  Found 15 directed moves and 0 covered components.
## sage: M.plot()
## Launched png viewer for Graphics object consisting of 221 graphics primitives
## sage: M = DirectedMoveCompositionCompletion(moves)
## sage: M.plot()
## Launched png viewer for Graphics object consisting of 16 graphics primitives
## sage: moves = [ FunctionalDirectedMove([(0, 1/2^n)], (1, 1 - 1/2^n)) for n in range(1, 4) ]
## sage: M.plot()
## Launched png viewer for Graphics object consisting of 16 graphics primitives
## sage: M = DirectedMoveCompositionCompletion(moves)
## sage: M.plot()
## Launched png viewer for Graphics object consisting of 16 graphics primitives
## sage: M.complete()
## INFO: 2019-01-21 19:48:54,569 Completing 6 functional directed moves and 0 covered components...
## INFO: 2019-01-21 19:48:54,583 Completing 13 functional directed moves and 0 covered components...
## INFO: 2019-01-21 19:48:54,607 Completing 15 functional directed moves and 0 covered components...
## INFO: 2019-01-21 19:48:54,630 Completing 15 functional directed moves and 0 covered components...
## INFO: 2019-01-21 19:48:54,638 Completing 15 functional directed moves and 0 covered components...
## INFO: 2019-01-21 19:48:54,648 Completion finished.  Found 15 directed moves and 0 covered components.
## sage: M.plot()
## Launched png viewer for Graphics object consisting of 221 graphics primitives
fname = destdir + "limit_to_empty_2_n" + "-%s" + ftype
moves = [ FunctionalDirectedMove([(0, 1/2^n)], (1, 1 - 1/2^n)) for n in range(1, 6) ] + [ FunctionalDirectedMove([(0,1)], (1, 0))]
M = DirectedMoveCompositionCompletion(moves, show_plots=fname)
M.complete()
## INFO: 2019-01-21 19:51:10,740 Completion finished.  Found 63 directed moves and 0 covered components.

## sage: moves = [ FunctionalDirectedMove([(0, 1/2^(n+1))], (1, 1 - 1/2^n)) for n in range(1, 5) ] + [ Functional
## ....: DirectedMove([(0,1)], (1, 0))]
## sage: M = DirectedMoveCompositionCompletion(moves)
## sage: M.plot()
## Launched png viewer for Graphics object consisting of 26 graphics primitives
## sage: M.complete()
## INFO: 2019-01-21 20:00:25,304 Completing 9 functional directed moves and 0 covered components...
## INFO: 2019-01-21 20:00:25,329 Completing 21 functional directed moves and 0 covered components...
## INFO: 2019-01-21 20:00:25,354 Completion finished.  Found 21 directed moves and 0 covered components.
## sage: M.plot()
## Launched png viewer for Graphics object consisting of 107 graphics primitives
## sage: moves = [ FunctionalDirectedMove([(0, 1/2^(n+1))], (1, 1 - 1/2^n)) for n in range(1, 6) ] + [ Functional
## ....: DirectedMove([(0,1)], (1, 0))]
## sage: M = DirectedMoveCompositionCompletion(moves)
## sage: M.plot()
## Launched png viewer for Graphics object consisting of 31 graphics primitives
## sage: M.complete()
## INFO: 2019-01-21 20:02:43,995 Completing 11 functional directed moves and 0 covered components...
## INFO: 2019-01-21 20:02:44,034 Completing 31 functional directed moves and 0 covered components...
## INFO: 2019-01-21 20:02:44,082 Completion finished.  Found 31 directed moves and 0 covered components.
## sage: M.plot()
## Launched png viewer for Graphics object consisting of 159 graphics primitives
## sage: moves = [ FunctionalDirectedMove([(0, 1/3^n)], (1, 1 - 1/2^n)) for n in range(1, 6) ] + [ FunctionalDire
## ....: ctedMove([(0,1)], (1, 0))]
## sage: M = DirectedMoveCompositionCompletion(moves)

fname = destdir + "limit_to_empty_3_n" + "-%s" + ftype
moves = [ FunctionalDirectedMove([(0, 1/3^n)], (1, 1 - 1/3^n)) for n in range(1, 6) ] + [ FunctionalDirectedMove([(0,1)], (1, 0))]
M = DirectedMoveCompositionCompletion(moves, show_plots=fname)
M.complete()
save_show_moves_with_discontinuity_markers = igp.show_moves_with_discontinuity_markers
igp.show_moves_with_discontinuity_markers = False
show_plot(M.plot(), fname, tag="completion-final-no-circles")
igp.show_moves_with_discontinuity_markers = save_show_moves_with_discontinuity_markers

## INFO: 2019-01-21 20:10:04,836 Completing 11 functional directed moves and 0 covered components...
## INFO: 2019-01-21 20:10:04,885 Completing 31 functional directed moves and 0 covered components...
## INFO: 2019-01-21 20:10:04,961 Completing 91 functional directed moves and 0 covered components...
## INFO: 2019-01-21 20:10:05,163 Completing 131 functional directed moves and 0 covered components...
## INFO: 2019-01-21 20:10:05,475 Completing 199 functional directed moves and 0 covered components...
## INFO: 2019-01-21 20:10:05,942 Completing 217 functional directed moves and 0 covered components...
## INFO: 2019-01-21 20:10:06,427 Completing 239 functional directed moves and 0 covered components...
## INFO: 2019-01-21 20:10:06,857 Completing 241 functional directed moves and 0 covered components...
## INFO: 2019-01-21 20:10:07,246 Completing 243 functional directed moves and 0 covered components...
## INFO: 2019-01-21 20:10:07,586 Completion finished.  Found 243 directed moves and 0 covered components.
