#!/bin/bash
rm -f *.000*
rm -f *.out
mpiexec -n 4 ./microhh init drycbl_flow
mpiexec -n 4 ./microhh run drycbl_flow
mv u.0000002 u.0000002ref
mv v.0000002 v.0000002ref
mv w.0000002 w.0000002ref
mv b.0000002 b.0000002ref
mv time.0000002 time.0000002ref
mpiexec -n 4 ./microhh run drycbl_flow_restart
cmp u.0000002 u.0000002ref
diffu=$?
cmp v.0000002 v.0000002ref
diffv=$?
cmp w.0000002 w.0000002ref
diffw=$?
cmp b.0000002 b.0000002ref
diffs=$?
error=$(($diffu + $diffv + $diffw + $diffs))
if [ $error = 0 ]; then
  echo "TEST PASSED!"
else
  echo "TEST FAILED!"
fi

