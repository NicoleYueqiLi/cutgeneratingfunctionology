def covered_intervals_by_adding_face(face, edges, already_covered):

    covered_intervals = copy(already_covered)
    # add a new 2d-face, update directly covered intervals
    component = []
    for int1 in face.minimal_triple:
        component.append(interval_mod_1(int1))
    component.sort()
    component = merge_within_comp(component)
    covered_intervals.append(component)
            
    remove_duplicate(covered_intervals)

    for i in range(len(covered_intervals)):
        for j in range(i+1, len(covered_intervals)):
            if find_interior_intersection(covered_intervals[i], covered_intervals[j]):
                covered_intervals[j] = merge_two_comp(covered_intervals[i],covered_intervals[j])
                covered_intervals[i] = []
                    
    covered_intervals = remove_empty_comp(covered_intervals)

    # update indirect covered intervals
    any_change = True
    
    while any_change:
        any_change = False
        for edge in edges:
            intervals = []
            # 0 stands for I; 1 stands for J; 2 stands for K
            IJK = []
            for i in range(len(edge)):
                if len(edge[i]) == 2:
                    intervals.append(edge[i])
                    IJK.append(i)
            if edge_merge(covered_intervals,intervals,IJK):
                any_change = True

    covered_intervals = remove_empty_comp(covered_intervals)
    return covered_intervals
    
#def random_face(q):
#    ii_left = ZZ.random_element(q)
#    ii_right = ZZ.random_element(ii_left, q)
#    jj_left = ZZ.random_element(q)
#    jj_right = ZZ.random_element(jj_left, q)
#    kk_left = ZZ.random_element(ii_left + jj_left, ii_right + jj_right + 1)
#    kk_right = ZZ.random_element(kk_left, ii_right + jj_right + 1)
#    return Face(([ii_left / q, ii_right / q], [jj_left / q, jj_right / q], [kk_left / q, kk_right / q]))
    
def pick_random_face(q, ff, aa, bb, to_cover):
    while True:
        x = pick_random_integer(q, to_cover)
        y = pick_random_integer(q, to_cover)
        z = ZZ.random_element(2)
        if (x + y + z == aa - 1) or (x + y + z == bb):
            continue
        #if (x, y + 1) == (ff, ff) or (x + 1, y) == (ff, ff) or (x + z, y + z) == (ff, ff):
        #    continue
        i = [x/q, (x+1)/q]
        j = [y/q, (y+1)/q]
        if z == 0:
            k = [(x+y)/q, (x+y+1)/q]
        else:
            k = [(x+y+1)/q, (x+y+2)/q]
        return Face((i,j,k))

def pick_random_integer(q, to_cover):
    n = ZZ.random_element(len(to_cover))
    x = int(to_cover[n][0] * q)
    y = int(to_cover[n][1] * q)
    z = ZZ.random_element(x,y)
    return z

def generate_painted_complex(q, ff, aa):
    """
    q, ff, aa are integers.
    3 <= ff < q and aa < ff/2
    q = grid_nb = lcm of denomiators.
    f = ff/q.
    [(aa-1)/q, aa/q] is not covered.
    by reflection, [bb/q, (bb+1)/q] is also not covered, where bb = ff-aa.
    """
    f = ff / q
    a = aa / q
    grid = 1 / q
    bb = ff - aa
    b = bb / q
    # suppose that aa < bb
    final_uncovered = [[a - grid, a], [b, b + grid]]
    # reflection
    faces_1d = [ Face(([0,f], [0,f], [f])), Face(([f,1], [f,1], [1+f]))]
    # translation 
    faces_1d += [ Face(([b - a + grid], [a - grid, a], [b, b + grid])), \
               Face(([a - grid, a], [b - a + grid], [b, b + grid])) ]
    edges = [ face.minimal_triple for face in faces_1d ]
    faces = []
    # first paint lower left and upper right corner?
    already_covered = []
    to_cover = interval_minus_union_of_intervals([0,1], final_uncovered)
    # logging.info("Need to cover %s" % to_cover)
    while to_cover:
        face = pick_random_face(q, ff, aa, bb, to_cover)
        #logging.info("Try %s" % face)
        new_covered = covered_intervals_by_adding_face(face, edges, already_covered)
        if not intersect_with_segments(new_covered, [a - grid]):
            faces.append(face)
            if face.minimal_triple[0] != face.minimal_triple[1]:
                faces.append(x_y_swapped_face(face))
            already_covered = new_covered
            merged_covered = reduce(merge_two_comp, new_covered)           
            to_cover = interval_minus_union_of_intervals([0,1], merge_two_comp(merged_covered, final_uncovered))
            #logging.info("After painting this face green, it remains %s" % to_cover)
    green_faces = faces + faces_1d
    #print already_covered
    covered_intervals = [merge_within_comp(component, one_point_overlap_suffices=True) for component in already_covered] 
    return green_faces, covered_intervals

def intersect_with_segments(covered_interval, segments_left_endpoints):
    for intervals in covered_interval:
        for i in intervals:
            for j in segments_left_endpoints:
                if i[0] <= j < i[1]:
                    return True
    return False


def plot_painted_faces(q, ff, faces):
    """
    Return a plot of the horizonal lines, vertical lines, and diagonal lines of the complex.
    """
    bkpt = [x/q for x in range(q+1)]
    x = var('x')
    p = Graphics()
    kwds ={}
    #kwds = { 'legend_label': "Complex Delta pi" }
    plot_kwds_hook(kwds)
    ## We now use lambda functions instead of Sage symbolics for plotting, 
    ## as those give strange errors when combined with our RealNumberFieldElement.
    for i in range(1,len(bkpt)):
        p += plot(lambda x: bkpt[i]-x, (x, 0, bkpt[i]), color='grey', **kwds)
        kwds = {}
    for i in range(1,len(bkpt)-1):
        p += plot(lambda x: (1+bkpt[i]-x), (x, bkpt[i], 1), color='grey')
    for i in range(len(bkpt)):
        p += plot(bkpt[i], (0, 1), color='grey')
    y=var('y')
    for i in range(len(bkpt)):
        p += parametric_plot((bkpt[i],y),(y,0,1), color='grey')
    #kwds = { 'legend_label': "Additive face" }
    plot_kwds_hook(kwds)
    for face in faces:
        p += face.plot(**kwds)
        delete_one_time_plot_kwds(kwds)

    I_J_verts = set()
    K_verts = set()
    kwds = { 'alpha': proj_plot_alpha, 'zorder': -10 }

    IJK_kwds = [ kwds for i in range(3) ]
    #kwds['legend_label'] = "projections p1(F), p2(F), p3(F)"
    
    for i in range(3):
        #IJK_kwds[i]['legend_color'] = proj_plot_colors[i] # does not work in Sage 5.11
        IJK_kwds[i]['color'] = proj_plot_colors[i]
        plot_kwds_hook(IJK_kwds[i])
    for face in faces:
        I, J, K = face.minimal_triple
        I_J_verts.update(I) # no need for J because the x-y swapped face will also be processed
        K_verts.update(K)
        if face.is_2D():
            # plot I at top border
            p += polygon([(I[0], 1), (I[1], 1), (I[1], 1 + proj_plot_width), (I[0], 1 + proj_plot_width)], **IJK_kwds[0])
            delete_one_time_plot_kwds(IJK_kwds[0])
            # plot J at left border
            p += polygon([(0, J[0]), (0, J[1]), (-proj_plot_width, J[1]), (-proj_plot_width, J[0])], **IJK_kwds[1])
            delete_one_time_plot_kwds(IJK_kwds[1])
            # plot K at right/bottom borders
            if coho_interval_contained_in_coho_interval(K, [0,1]):
                p += polygon([(K[0], 0), (K[1], 0), (K[1] + proj_plot_width, -proj_plot_width), (K[0] + proj_plot_width, -proj_plot_width)], **IJK_kwds[2])
            elif coho_interval_contained_in_coho_interval(K, [1,2]):
                p += polygon([(1, K[0]-1), (1, K[1]-1), (1 + proj_plot_width, K[1] - 1 - proj_plot_width), (1 + proj_plot_width, K[0] - 1 - proj_plot_width)], **IJK_kwds[2])
            else:
                raise ValueError, "Bad face: %s" % face
            delete_one_time_plot_kwds(IJK_kwds[2])
    return p

def generate_additive_vertices_from_faces(q, faces):
    additive_vertices = set()
    for face in faces:
        if face.is_2D():
            # suppose every 2d-face is a unit triangle
            for (x, y) in face.vertices:
                if x <= y:
                    additive_vertices.add((x, y))
        elif face.is_0D():
            additive_vertices.add(face.vertices)
        else:
            i, j, k = face.minimal_triple
            if face.is_horizontal():
                for x in range(i[0]*q, i[1]*q + 1):
                    if x/q <= j[0]:
                        additive_vertices.add((x/q, j[0]))
            elif face.is_vertical():
                for y in range(j[0]*q, j[1]*q + 1):
                    if i[0] <= y/q:
                        additive_vertices.add((j[0], y/q))
            else:
                for x in range(i[0]*q, i[1]*q + 1):
                    if 2*x/q <= k[0]:
                        additive_vertices.add((x/q, k[0] - x/q))   
    return additive_vertices
    
def generate_ieqs_and_eqns(q, ff, fn_sym, additive_vertices):
    ieqs = []
    eqns = []
    for x in range(q):
        v = fn_sym(x/q)
        ieq_0 = [0] + list(v)  # fn(x/q) >= 0
        ieq_1 = [1] + [-w for w in v] #fn(x/q) <=1
        ieqs += [ieq_0, ieq_1]
    eqns += [[0] + list(fn_sym(0)), [0] + list(fn_sym(1)), [-1] + list(fn_sym(ff/q))] #fn(0) = 0; fn(1) = 0; fn(f) = 1;
    bkpt = fn_sym.end_points()
    for x in bkpt:
        for y in bkpt:
            if x <= y:
                v = [0] + list(delta_pi(fn_sym,x,y))
                if (x, y) in additive_vertices:
                    eqns.append(v)
                else:
                    ieqs.append(v)
    bkpt2 = bkpt[:-1] + [ x+1 for x in bkpt ]
    for x in bkpt:
        for z in bkpt2:
            if x < z < 1+x:
                y = z - x
                v = [0] + list(delta_pi(fn_sym,x,y))
                if (x, y) in additive_vertices or (y, x) in additive_vertices:
                    eqns.append(v)
                else:
                    ieqs.append(v)
    return ieqs, eqns

def generate_vertex_function(q, ff, fn_sym, additive_vertices):
    ieqs, eqns = generate_ieqs_and_eqns(q, ff, fn_sym, additive_vertices)
    p = Polyhedron(ieqs = ieqs, eqns = eqns)
    if not p.is_empty():
        # print "p.Vrepresentation() is:" 
        # print p.Vrepresentation()
        # print "boundedness is %s" % p.is_compact()
        for x in p.vertices():
            k = len(set(x))
            if k > 2: # can even write k > 3
                print "%s gives a %s-slope function h =" % (x, k) 
                v = vector(QQ,x)
                yield v * fn_sym
            else:
                print "%s gives a %s-slope function. Ignore" % (x, k) 

def random_2q_example(q, ff, aa):
    """
    q, ff, aa are integers.
    3 <= ff < q and aa < ff/2
    want to find a function h with 2 uncovered segments:
    [(aa-1)/q, aa/q], [bb/q, (bb+1)/q] which are related by translation and reflection,
    such that:
        h is not extreme (i.e h restricted to 1/3q is not extreme), but
        h restricted to 1/2q is extreme

    EXAMPLES::

        sage: logging.disable(logging.INFO)
        sage: random_2q_example(13, 10, 4)
        sage: logging.disable()
    """
    attempts = 0
    while attempts < 100:
        # print "attempt #%s" % attempts
        green_faces, covered_intervals = generate_painted_complex(q, ff, aa)
        additive_vertices = generate_additive_vertices_from_faces(q, green_faces)
        f = ff / q
        final_uncovered = [[(aa - 1) / q, aa / q], [(ff - aa) / q, (ff - aa + 1) / q]]
        components = covered_intervals  + [final_uncovered]
        fn_sym = generate_symbolic_continuous(None, components, field=QQ)
        for h in generate_vertex_function(q, ff, fn_sym, additive_vertices):
            print h
            # should check if final_nucovered is indeed uncovered. 
            # often it is not the case. then h is not a good example.
            if not extremality_test(h): # h is not extreme
                h_2q = restrict_to_finite_group(h, f=f, oversampling=2, order=None)
                if extremality_test(h_2q): # but h restricted to 1/2q is extreme
                    return h
                else:
                    print "h restricted to 1/2q is not extreme. Not a good example"
            else:
                print "h is extreme. Not a good example"
        attempts += 1
    print "Example function not found. Please try again."