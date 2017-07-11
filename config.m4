dnl $Id$
dnl config.m4 for extension gmsm

PHP_ARG_WITH(gmsm, for gmsm support,
[  --with-gmsm             Include gmsm support])

PHP_ARG_ENABLE(gmsm, whether to enable gmsm support,
[  --enable-gmsm           Enable gmsm support])

if test "$PHP_GMSM" != "no"; then
  PHP_NEW_EXTENSION(gmsm,
    miracl/mrcore.c                    \
    miracl/mrarth0.c                   \
    miracl/mrarth1.c                   \
    miracl/mrarth2.c                   \
    miracl/mralloc.c                   \
    miracl/mrsmall.c                   \
    miracl/mrio1.c                     \
    miracl/mrio2.c                     \
    miracl/mrgcd.c                     \
    miracl/mrjack.c                    \
    miracl/mrxgcd.c                    \
    miracl/mrarth3.c                   \
    miracl/mrbits.c                    \
    miracl/mrrand.c                    \
    miracl/mrprime.c                   \
    miracl/mrcrt.c                     \
    miracl/mrscrt.c                    \
    miracl/mrmonty.c                   \
    miracl/mrpower.c                   \
    miracl/mrsroot.c                   \
    miracl/mrcurve.c                   \
    miracl/mrfast.c                    \
    miracl/mrshs.c                     \
    miracl/mrshs256.c                  \
    miracl/mrshs512.c                  \
    miracl/mrsha3.c                    \
    miracl/mrfpe.c                     \
    miracl/mraes.c                     \
    miracl/mrgcm.c                     \
    miracl/mrlucas.c                   \
    miracl/mrzzn2.c                    \
    miracl/mrzzn2b.c                   \
    miracl/mrzzn3.c                    \
    miracl/mrzzn4.c                    \
    miracl/mrecn2.c                    \
    miracl/mrstrong.c                  \
    miracl/mrbrick.c                   \
    miracl/mrebrick.c                  \
    miracl/mrec2m.c                    \
    miracl/mrgf2m.c                    \
    miracl/mrflash.c                   \
    miracl/mrfrnd.c                    \
    miracl/mrdouble.c                  \
    miracl/mrround.c                   \
    miracl/mrbuild.c                   \
    miracl/mrflsh1.c                   \
    miracl/mrpi.c                      \
    miracl/mrflsh2.c                   \
    miracl/mrflsh3.c                   \
    miracl/mrflsh4.c                   \
    miracl/mrmuldv.c                   \
    miracl/bmark.c                     \
    sm2/GMSM2.c                        \
    sm3/GMSM3.c                        \
    sm4/GMSM4.c                        \
    utils/BCD.c                        \
    gmsm.c,
  $ext_shared)
  PHP_ADD_BUILD_DIR([$ext_builddir/sm2])
  PHP_ADD_BUILD_DIR([$ext_builddir/sm3])
  PHP_ADD_BUILD_DIR([$ext_builddir/sm4])
  PHP_ADD_BUILD_DIR([$ext_builddir/miracl])
  PHP_ADD_BUILD_DIR([$ext_builddir/utils])
fi
