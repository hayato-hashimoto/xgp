(use gauche.test)
(test-start "xgp module")
(load "./xgp.scm")

(define g (xgp-create))
(xgp-create-node g 'root)

(test-section "xgp low-level node manipulation")
(xgp-append! g (first (xgp-nodes-by-label g 'root)) (xgp-create-node g :a))
(test* "xgp-append!" (first (xgp-nodes-by-label g :a)) (last (xgp-children g (first (xgp-nodes-by-label g 'root)))) eq?)

(xgp-after! g (first (xgp-nodes-by-label g :a)) (xgp-create-node g :b))
(test* "xgp-after!" (first (xgp-nodes-by-label g :b)) (last (xgp-children g (first (xgp-nodes-by-label g 'root)))) eq?)
(xgp-after! g (first (xgp-nodes-by-label g :a)) (xgp-create-node g :c))
(test* "xgp-after!" (first (xgp-nodes-by-label g :c)) (second (xgp-children g (first (xgp-nodes-by-label g 'root)))) eq?)
(xgp-append! g (xgp-create-node g :another-parent) (first (xgp-nodes-by-label g :c)))
(test* "xgp-after!" (first (xgp-nodes-by-label g :another-parent)) (xgp-parents g (first (xgp-nodes-by-label g :c)))

(xgp-wrap! g (first (xgp-nodes-by-label g :a) (xgp-create-node g :x)))

(test-section "xgp sexp->node conversion")

(with-module xgp 
 (let1 template (sexp->node `(root (c (@ ,inverse (,any (@ class x))))))
 (xgp-query ($wrap ($class :x template))))

(test-section "xgp nodeset manipulation")
(xgp-query g ($wrap ($children ($label :root))))

