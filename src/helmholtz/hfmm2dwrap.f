cc Copyright (C) 2010-2011: Leslie Greengard, Zydrunas Gimbustas 
cc and Manas Rachh
cc Contact: greengard@cims.nyu.edu
cc 
cc This program is free software; you can redistribute it and/or modify 
cc it under the terms of the GNU General Public License as published by 
cc the Free Software Foundation; either version 2 of the License, or 
cc (at your option) any later version.  This program is distributed in 
cc the hope that it will be useful, but WITHOUT ANY WARRANTY; without 
cc even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
cc PARTICULAR PURPOSE.  See the GNU General Public License for more 
cc details. You should have received a copy of the GNU General Public 
cc License along with this program; 
cc if not, see <http://www.gnu.org/licenses/>.



c       
c   Helmholtz FMM in R^2: evaluate all pairwise particle
c   interactions (ignoring self-interaction) 
c   and interactions with targets.
c
c   We use H_0(kr)*(i/4) for the Green's function.
c   Self-interactions are not included
c
c   h2d: charge and dipstr are complex valued, x in \R^2
c
c   \phi(x_i) = (i/4)\sum_{j\ne i} charge_j H^{(1)}_0(k |x_i - x_j|)
c   + dipstr_j (dipvec_j \dot (x_i - x_j)) H^{(1)}_1(k |x_i - x_j|*
c                                          k/|x_i-x_j|
c
c

      subroutine hfmm2dpartstostcp(eps,zk,ns,sources,
     1            charge,pot,nt,targ,pottarg)
c----------------------------------------------
c   INPUT PARAMETERS:
c   eps           : FMM precision requested
c   zk            : Helmholtz parameter
c   ns            : number of sources
c   sources(2,ns) : source locations
c   charge(ns)    : charge strengths
c   nt            : number of targets
c   targ(2,nt)    : target locations
c
c   OUTPUT PARAMETERS
c   pot(ns)       : potential at the source locations
c   pottarg(nt)   : potential at the target locations
c


      implicit none
c
cc      calling sequence variables
c  
      real *8 eps
      complex *16 zk
      integer ns,nt
      real *8 sources(2,ns),targ(2,nt)
      complex *16 charge(ns)

      complex *16 pot(ns)
      complex *16 pottarg(nt)

c
cc     temporary variables
c
      complex *16 dipstr
      real *8 dipvec(2)
      complex *16 grad(2),gradtarg(2)
      complex *16 hess(3),hesstarg(3)
      integer ifcharge,ifdipole,iper
      integer ifpgh,ifpghtarg

      integer nd

      ifcharge = 1
      ifdipole = 0
      
      ifpgh = 1
      ifpghtarg = 1

      nd = 1

      call hfmm2dpart(nd,eps,zk,ns,sources,ifcharge,charge,
     1            ifdipole,dipstr,dipvec,iper,ifpgh,pot,grad,hess,
     2            nt,targ,ifpghtarg,pottarg,gradtarg,
     3            hesstarg)
      return
      end
c------------------------------


      subroutine hfmm2dpartstostcg(eps,zk,ns,sources,
     1            charge,pot,grad,nt,targ,pottarg,gradtarg)
c----------------------------------------------
c   INPUT PARAMETERS:
c   eps           : FMM precision requested
c   zk            : Helmholtz parameter
c   ns            : number of sources
c   sources(2,ns) : source locations
c   charge(ns)    : charge strengths
c   nt            : number of targets
c   targ(2,nt)    : target locations
c
c   OUTPUT PARAMETERS
c   pot(ns)       : potential at the source locations
c   grad(2,ns)    : gradients at the source locations
c   pottarg(nt)   : potential at the target locations
c   gradtarg(2,nt): gradient at the target locations
c


      implicit none
c
cc      calling sequence variables
c  
      real *8 eps
      complex *16 zk
      integer ns,nt
      real *8 sources(2,ns),targ(2,nt)
      complex *16 charge(ns)

      complex *16 pot(ns),grad(2,ns)
      complex *16 pottarg(nt),gradtarg(2,nt)

c
cc     temporary variables
c
      complex *16 dipstr
      real *8 dipvec(2)
      complex *16 hess(3),hesstarg(3)
      integer ifcharge,ifdipole,iper
      integer ifpgh,ifpghtarg
      integer nd

      ifcharge = 1
      ifdipole = 0
      
      ifpgh = 2
      ifpghtarg = 2

      nd = 1

      call hfmm2dpart(nd,eps,zk,ns,sources,ifcharge,charge,
     1            ifdipole,dipstr,dipvec,iper,ifpgh,pot,grad,hess,
     2            nt,targ,ifpghtarg,pottarg,gradtarg,
     3            hesstarg)
      return
      end
c------------------------------
c
c
c
c
c
      subroutine hfmm2dpartstostch(eps,zk,ns,sources,
     1            charge,pot,grad,hess,nt,targ,pottarg,
     2            gradtarg,hesstarg)
c----------------------------------------------
c   INPUT PARAMETERS:
c   eps           : FMM precision requested
c   zk            : Helmholtz parameter
c   ns            : number of sources
c   sources(2,ns) : source locations
c   charge(ns)    : charge strengths
c   nt            : number of targets
c   targ(2,nt)    : target locations
c
c   OUTPUT PARAMETERS
c   pot(ns)       : potential at the source locations
c   grad(2,ns)    : gradients at the source locations
c   hess(3,ns)    : hessian at the source locations
c   pottarg(nt)   : potential at the target locations
c   gradtarg(2,nt): gradient at the target locations
c   hesstarg(3,nt): hessian at the target locations
c


      implicit none
c
cc      calling sequence variables
c  
      real *8 eps
      complex *16 zk
      integer ns,nt
      real *8 sources(2,ns),targ(2,nt)
      complex *16 charge(ns)

      complex *16 pot(ns),grad(2,ns),hess(3,ns)
      complex *16 pottarg(nt),gradtarg(2,nt),hesstarg(3,nt)

c
cc     temporary variables
c
      complex *16 dipstr
      real *8 dipvec(2)
      integer ifcharge,ifdipole,iper
      integer ifpgh,ifpghtarg
      integer nd

      ifcharge = 1
      ifdipole = 0
      
      ifpgh = 3
      ifpghtarg = 3

      nd = 1

      call hfmm2dpart(nd,eps,zk,ns,sources,ifcharge,charge,
     1            ifdipole,dipstr,dipvec,iper,ifpgh,pot,grad,hess,
     2            nt,targ,ifpghtarg,pottarg,gradtarg,
     3            hesstarg)
      return
      end


c-------------------------------      

      subroutine hfmm2dpartstostdp(eps,zk,ns,sources,
     1            dipstr,dipvec,pot,nt,targ,pottarg)
c----------------------------------------------
c   INPUT PARAMETERS:
c   eps           : FMM precision requested
c   zk            : Helmholtz parameter
c   ns            : number of sources
c   sources(2,ns) : source locations
c   dipstr(ns)    : dipole strengths
c   dipvec(2,ns)  : dipole orientation vectors
c   nt            : number of targets
c   targ(2,nt)    : target locations
c
c   OUTPUT PARAMETERS
c   pot(ns)       : potential at the source locations
c   pottarg(nt)   : potential at the target locations
c


      implicit none
c
cc      calling sequence variables
c  
      real *8 eps
      complex *16 zk
      integer ns,nt
      real *8 sources(2,ns),targ(2,nt)
      real *8 dipvec(2,ns)
      complex *16 dipstr(ns)

      complex *16 pot(ns)
      complex *16 pottarg(nt)

c
cc     temporary variables
c
      complex *16 charge
      complex *16 grad(2),gradtarg(2)
      complex *16 hess(3),hesstarg(3)
      integer ifcharge,ifdipole,iper
      integer ifpgh,ifpghtarg

      integer nd

      ifcharge = 0
      ifdipole = 1
      
      ifpgh = 1
      ifpghtarg = 1

      nd = 1

      call hfmm2dpart(nd,eps,zk,ns,sources,ifcharge,charge,
     1            ifdipole,dipstr,dipvec,iper,ifpgh,pot,grad,hess,
     2            nt,targ,ifpghtarg,pottarg,gradtarg,
     3            hesstarg)
      return
      end
c------------------------------


      subroutine hfmm2dpartstostdg(eps,zk,ns,sources,
     1            dipstr,dipvec,pot,grad,nt,targ,pottarg,gradtarg)
c----------------------------------------------
c   INPUT PARAMETERS:
c   eps           : FMM precision requested
c   zk            : Helmholtz parameter
c   ns            : number of sources
c   sources(2,ns) : source locations
c   dipstr(ns)    : dipole strengths
c   dipvec(2,ns)  : dipole orientation vectors
c   nt            : number of targets
c   targ(2,nt)    : target locations
c
c   OUTPUT PARAMETERS
c   pot(ns)       : potential at the source locations
c   grad(2,ns)    : gradients at the source locations
c   pottarg(nt)   : potential at the target locations
c   gradtarg(2,nt): gradient at the target locations
c


      implicit none
c
cc      calling sequence variables
c  
      real *8 eps
      complex *16 zk
      integer ns,nt
      real *8 sources(2,ns),targ(2,nt)
      real *8 dipvec(2,ns)
      complex *16 dipstr(ns)

      complex *16 pot(ns),grad(2,ns)
      complex *16 pottarg(nt),gradtarg(2,nt)

c
cc     temporary variables
c
      complex *16 charge
      complex *16 hess(3),hesstarg(3)
      integer ifcharge,ifdipole,iper
      integer ifpgh,ifpghtarg
      integer nd

      ifcharge = 0
      ifdipole = 1
      
      ifpgh = 2
      ifpghtarg = 2

      nd = 1

      call hfmm2dpart(nd,eps,zk,ns,sources,ifcharge,charge,
     1            ifdipole,dipstr,dipvec,iper,ifpgh,pot,grad,hess,
     2            nt,targ,ifpghtarg,pottarg,gradtarg,
     3            hesstarg)
      return
      end
c------------------------------
c
c
c
c
c
      subroutine hfmm2dpartstostdh(eps,zk,ns,sources,
     1            dipstr,dipvec,pot,grad,hess,nt,targ,pottarg,
     2            gradtarg,hesstarg)
c----------------------------------------------
c   INPUT PARAMETERS:
c   eps           : FMM precision requested
c   zk            : Helmholtz parameter
c   ns            : number of sources
c   sources(2,ns) : source locations
c   dipstr(ns)    : dipole strengths
c   dipvec(2,ns)  : dipole orientation vectors
c   nt            : number of targets
c   targ(2,nt)    : target locations
c
c   OUTPUT PARAMETERS
c   pot(ns)       : potential at the source locations
c   grad(2,ns)    : gradients at the source locations
c   hess(3,ns)    : hessian at the source locations
c   pottarg(nt)   : potential at the target locations
c   gradtarg(2,nt): gradient at the target locations
c   hesstarg(3,nt): hessian at the target locations
c


      implicit none
c
cc      calling sequence variables
c  
      real *8 eps
      complex *16 zk
      integer ns,nt
      real *8 sources(2,ns),targ(2,nt)
      real *8 dipvec(2,ns)
      complex *16 dipstr(ns)

      complex *16 pot(ns),grad(2,ns),hess(3,ns)
      complex *16 pottarg(nt),gradtarg(2,nt),hesstarg(3,nt)

c
cc     temporary variables
c
      complex *16 charge
      integer ifcharge,ifdipole,iper
      integer ifpgh,ifpghtarg
      integer nd

      ifcharge = 0
      ifdipole = 1
      
      ifpgh = 3
      ifpghtarg = 3

      nd = 1

      call hfmm2dpart(nd,eps,zk,ns,sources,ifcharge,charge,
     1            ifdipole,dipstr,dipvec,iper,ifpgh,pot,grad,hess,
     2            nt,targ,ifpghtarg,pottarg,gradtarg,
     3            hesstarg)
      return
      end


c-------------------------------      

      subroutine hfmm2dpartstostcdp(eps,zk,ns,sources,charge,
     1            dipstr,dipvec,pot,nt,targ,pottarg)
c----------------------------------------------
c   INPUT PARAMETERS:
c   eps           : FMM precision requested
c   zk            : Helmholtz parameter
c   ns            : number of sources
c   sources(2,ns) : source locations
c   charge(ns)    : charge strengths
c   dipstr(ns)    : dipole strengths
c   dipvec(2,ns)  : dipole orientation vectors
c   nt            : number of targets
c   targ(2,nt)    : target locations
c
c   OUTPUT PARAMETERS
c   pot(ns)       : potential at the source locations
c   pottarg(nt)   : potential at the target locations
c


      implicit none
c
cc      calling sequence variables
c  
      real *8 eps
      complex *16 zk
      integer ns,nt
      real *8 sources(2,ns),targ(2,nt)
      real *8 dipvec(2,ns)
      complex *16 charge(ns),dipstr(ns)

      complex *16 pot(ns)
      complex *16 pottarg(nt)

c
cc     temporary variables
c
      complex *16 grad(2),gradtarg(2)
      complex *16 hess(3),hesstarg(3)
      integer ifcharge,ifdipole,iper
      integer ifpgh,ifpghtarg

      integer nd

      ifcharge = 1
      ifdipole = 1
      
      ifpgh = 1
      ifpghtarg = 1

      nd = 1

      call hfmm2dpart(nd,eps,zk,ns,sources,ifcharge,charge,
     1            ifdipole,dipstr,dipvec,iper,ifpgh,pot,grad,hess,
     2            nt,targ,ifpghtarg,pottarg,gradtarg,
     3            hesstarg)
      return
      end
c------------------------------


      subroutine hfmm2dpartstostcdg(eps,zk,ns,sources,charge,
     1            dipstr,dipvec,pot,grad,nt,targ,pottarg,gradtarg)
c----------------------------------------------
c   INPUT PARAMETERS:
c   eps           : FMM precision requested
c   zk            : Helmholtz parameter
c   ns            : number of sources
c   sources(2,ns) : source locations
c   charge(ns)    : charge strengths
c   dipstr(ns)    : dipole strengths
c   dipvec(2,ns)  : dipole orientation vectors
c   nt            : number of targets
c   targ(2,nt)    : target locations
c
c   OUTPUT PARAMETERS
c   pot(ns)       : potential at the source locations
c   grad(2,ns)    : gradients at the source locations
c   pottarg(nt)   : potential at the target locations
c   gradtarg(2,nt): gradient at the target locations
c

      implicit none
c
cc      calling sequence variables
c  
      real *8 eps
      complex *16 zk
      integer ns,nt
      real *8 sources(2,ns),targ(2,nt)
      real *8 dipvec(2,ns)
      complex *16 charge(ns),dipstr(ns)

      complex *16 pot(ns),grad(2,ns)
      complex *16 pottarg(nt),gradtarg(2,nt)

c
cc     temporary variables
c
      complex *16 hess(3),hesstarg(3)
      integer ifcharge,ifdipole,iper
      integer ifpgh,ifpghtarg
      integer nd

      ifcharge = 1
      ifdipole = 1
      
      ifpgh = 2
      ifpghtarg = 2

      nd = 1

      call hfmm2dpart(nd,eps,zk,ns,sources,ifcharge,charge,
     1            ifdipole,dipstr,dipvec,iper,ifpgh,pot,grad,hess,
     2            nt,targ,ifpghtarg,pottarg,gradtarg,
     3            hesstarg)
      return
      end
c------------------------------
c
c
c
c
c
      subroutine hfmm2dpartstostcdh(eps,zk,ns,sources,charge,
     1            dipstr,dipvec,pot,grad,hess,nt,targ,pottarg,
     2            gradtarg,hesstarg)
c----------------------------------------------
c   INPUT PARAMETERS:
c   eps           : FMM precision requested
c   zk            : Helmholtz parameter
c   ns            : number of sources
c   sources(2,ns) : source locations
c   charge(ns)    : charge strengths
c   dipstr(ns)    : dipole strengths
c   dipvec(2,ns)  : dipole orientation vectors
c   nt            : number of targets
c   targ(2,nt)    : target locations
c
c   OUTPUT PARAMETERS
c   pot(ns)       : potential at the source locations
c   grad(2,ns)    : gradients at the source locations
c   hess(3,ns)    : hessian at the source locations
c   pottarg(nt)   : potential at the target locations
c   gradtarg(2,nt): gradient at the target locations
c   hesstarg(3,nt): hessian at the target locations
c


      implicit none
c
cc      calling sequence variables
c  
      real *8 eps
      complex *16 zk
      integer ns,nt
      real *8 sources(2,ns),targ(2,nt)
      real *8 dipvec(2,ns)
      complex *16 charge(ns),dipstr(ns)

      complex *16 pot(ns),grad(2,ns),hess(3,ns)
      complex *16 pottarg(nt),gradtarg(2,nt),hesstarg(3,nt)

c
cc     temporary variables
c
      integer ifcharge,ifdipole,iper
      integer ifpgh,ifpghtarg
      integer nd

      ifcharge = 1
      ifdipole = 1
      
      ifpgh = 3
      ifpghtarg = 3

      nd = 1

      call hfmm2dpart(nd,eps,zk,ns,sources,ifcharge,charge,
     1            ifdipole,dipstr,dipvec,iper,ifpgh,pot,grad,hess,
     2            nt,targ,ifpghtarg,pottarg,gradtarg,
     3            hesstarg)
      return
      end

