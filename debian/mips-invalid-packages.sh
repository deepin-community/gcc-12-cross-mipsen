#!/bin/sh

cp -f debian/packages.invalid xx

for pkg in asan8 itm1 lsan0 ubsan1;do
for a in mips mipsel mipsr6 mipsr6el mips64 mips64el mips64r6 mips64r6el mipsn32 mipsn32el mipsn32r6 mipsn32r6el;
do
	echo "lib${pkg}-${a}-cross" >> xx
	echo "lib32${pkg}-${a}-cross" >> xx
	echo "lib64${pkg}-${a}-cross" >> xx
	echo "libn32${pkg}-${a}-cross" >> xx
	echo "libx32${pkg}-${a}-cross" >> xx
done
done

for ca in libx32 libhf libsf;do
  pkg=`grep "^$ca" debian/packages.invalid | grep -v -- '-dbg-'  | awk -F'-' '{for (i=1; i<NF-1; i++) printf("%s-", $i); printf("\\n")}' | sort | uniq`
  for a in mips mipsel mipsr6 mipsr6el mips64 mips64el mips64r6 mips64r6el mipsn32 mipsn32el mipsn32r6 mipsn32r6el;
  do
      for p in $pkg;do
	echo "${p}${a}-cross" >> xx
      done
  done
done

for ca in lib32;do
  pkg=`grep "^$ca" debian/packages.invalid | grep -v -- '-dbg-'  | awk -F'-' '{for (i=1; i<NF-1; i++) printf("%s-", $i); printf("\\n")}' | sort | uniq`
  for a in mips mipsel mipsr6 mipsr6el;
  do
      for p in $pkg;do
	echo "${p}${a}-cross" >> xx
      done
  done
done

for ca in libn32;do
  pkg=`grep "^$ca" debian/packages.invalid | grep -v -- '-dbg-'  | awk -F'-' '{for (i=1; i<NF-1; i++) printf("%s-", $i); printf("\\n")}' | sort | uniq`
  for a in mipsn32 mipsn32el mipsn32r6 mipsn32r6el;
  do
      for p in $pkg;do
	echo "${p}${a}-cross" >> xx
      done
  done
done

for ca in lib64;do
  pkg=`grep "^$ca" debian/packages.invalid | grep -v -- '-dbg-'  | awk -F'-' '{for (i=1; i<NF-1; i++) printf("%s-", $i); printf("\\n")}' | sort | uniq`
  for a in mips64 mips64el mips64r6 mips64r6el;
  do
      for p in $pkg;do
	echo "${p}${a}-cross" >> xx
      done
  done
done

sort xx | uniq > debian/packages.invalid
rm -f xx
