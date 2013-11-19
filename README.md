FDImageCache
============

通过ASIHTTP异步加载图片，并加入高速缓存（内存）、文件缓存（磁盘），附带实例


继承UIImageView模式--FDImageView：

推荐使用该模式，经过测试无任何异常问题！
使用时需要通过FDImageView进行初始化


扩展UIImageView模式--UIImageView+FDCache：

不推荐使用在tableviewcell中，通常tableviewcell会使用dequeueReusableCellWithIdentifier进行重用处理，
因此所获得的cell是重用的、UIImageView也同样会被复用，滑动速度快、网络响应跟不上的话就会出现，将多个图片同时刷新到当前某个cell上。
这个问题，只在复用时会出现。


