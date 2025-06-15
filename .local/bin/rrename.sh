#!/usr/bin/env zsh


t0=$(mktemp)
t1=$(mktemp)
tscript=$(mktemp)
names=$(mktemp)

# undesired patterns




pattern="_[_]+|[ ]+|-+|[();,'&]+"


touch $tscript
chmod +x $tscript
grep -E "$pattern" <(ls) | awk '{ print length, $0 }' | sort  -n -k1,1  | awk '{$1=""; print $0}' | sed -E 's/^ //g'  > $names
# patterns to escape
sed -e "s/\([ '()&[;]\)/\\\\\\1/g"  $names | sed -e 's/\]/\\]/g' > $t0
sed -E "s/$pattern/_/g" $names | sed -E 's/&/_and_/g'  | tr '[:upper:]' '[:lower:]' | sed -E  s/'_[_]+/_/g'  > $t1
paste $t0 $t1 | sed -e "s/\(.*\)/mv -v \1/" > $tscript
# sed -i 's/\///g' $tscript
if [[ $1 == "test" ]]; then
    cat $tscript
else
    $tscript
fi


rm $t0 $t1 $tscript  $names
