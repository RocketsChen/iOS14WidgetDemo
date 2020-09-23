# iOS14 Widget体验

### 前言

iOS14发布已经有一段时间了，更新完之后最让我好奇的就是这个Widget功能。从用户使用到开发者开发上与iOS13有了很大的区别。用户可以更个性化的去组建自己的桌面。

看完这篇博客，你可以大概的了解一些关于iOS14Widget信息，和尝试编写一个简单的Widget小组件。

Widget代码演示部分可以直接跳至第三部分。

### 1：与iOS13 Widget区别


#### 不同点


最直观的区别就是系统演示视频展示的那样，可以直接展示在iPhone主屏幕进行组件的布局如下图

![](https://tva1.sinaimg.cn/large/007S8ZIlgy1giy1go2y2sj30w20u0azk.jpg)

* iOS13上的Widget是一个整体，在负1屏幕上的一个显示区域内的布局显示它们有专门的页面进行管理。而在14上每一个Widget都是一个单独的组件，他们可以自己管理自己通过简单的长按下压手势进行编辑和删除操作。


* iOS13上的Widget想要改变大小，只能通过一个右上角的下标箭头进行编辑扩展。一般就两种尺寸：NCWidgetDisplayMode的expanded和Compact属性。而在14改变成了三种尺寸：Widget只支持3种尺寸systemSmall （2x2）、 systemMedium （4x2）、 systemLarge（4x4） （以单个APP-icon大小为单元）。下图对比以13-Widget小历和14-Widget自带日历为对比。

iOS13-Widget
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1giy37on3r9j30n00ot41q.jpg) 

iOS14-Widget
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1giybbdu5cwj30n01790ux.jpg)

* iOS13上的Widget不支持部件堆叠，通过上下滑动切换。而在14上支持。14还支持在任意主界面上进行Widget页面的编辑。

除了显示上的区别外，代码的实现上也有不同

* iOS13上的Widget默认是根据开发语言的选择上为基础，生成组件。如OC的项目生成OC的Widget组件，Swift的项目生成Swift的Widget组件。而且14上则是默认里Swift和SwiftUI为语言基础进行开发。

* 在14上使用的是新的WidgetKit框架而非13的Today Extension。UI部分只能够使用SwiftUI来开发，所以需要一定的SwiftUI和Swift基础。

* 14的Widget需要依赖Xcode12.0版本。


#### 相同点

* 同一个APP都可以开发多个组件，也可以同时使用多个组件。

* 在和siri进行交互上，14上更加智能。如Widget堆叠的情况可以自动切换。


### 2：iOS14 Widget的特点


* 14的Widget可自定义的更强了，可以和主屏幕的APP一起排布，可以堆叠节省空间，集成siri的智能化推荐。

* 苹果在开发上更加的建议去如何设计一个漂亮的小部件（Widget），如通过颜色，版式和图像传达您的品牌，舒适的信息密度等，详情可查看[苹果开发文档](https://developer.apple.com/design/human-interface-guidelines/ios/system-capabilities/widgets)

* 适应不同的屏幕尺寸

|  屏幕尺寸 - portrait  | 小部件-systemSmall | 中型部件-systemMedium | 大部件-systemLarge |
| ------ | ------ |  ------ |  ------ | 
| 414x896 pt (XR/XsMax/11/11ProMax) | 169x169pt | 360x169pt | 360x379pt | 
| 375x812 pt (X/Xs/11 Pro) | 155x155 pt | 329x155 pt | 329x345 pt | 
| 414x736 pt (6p/6sp/7p) | 159x159 pt | 348x159 pt | 348x357 pt | 
| 375x667 pt (6/6s/7/8) | 148x148 pt | 321x148 pt | 321x324 pt | 
| 320x568 pt (5/5s/SE) | 	141x141 pt | 292x141 pt | 292x311 pt | 

* 支持Widget配置和交互

### 3：iOS14 Widget的代码实现

#### 1：项目创建

1：Widget作为项目的一个组件，创建之前需要先创建一个iOS的项目。

 * Create a new Xcode Project
 * 语言选择：Swift/OC

2：项目创建成功后点击：File->New->Target添加Widget Extension Target 点击Next。
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1giy8p9xe8hj314k0t813h.jpg)


3：输入Widget组件名，取消勾选，点击Finish就可以了。Include Configuration Intent：是否支持用户配置。

![](https://tva1.sinaimg.cn/large/007S8ZIlgy1giy94vc3frj314k0t8wnf.jpg)


4：如图可以看到默认生成的模板，默认组件的尺寸systemSmall。但是在真机上编译完可以看到Widget三个尺寸。在Xcode12上最右边可视化界面直接模拟器运行和真机编译。

![](https://tva1.sinaimg.cn/large/007S8ZIlgy1giy9wexamdj31780u04qp.jpg)


5：熟悉的Hello World之后开始编写新的demo。
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1giyanmcu9yj30lw0m4mxy.jpg)

6：上面预览视图的工具

* 最左边item：Live Preview ： Xcode视图预览
* 左边第二个：Preview on Device： 真机预览，会在你的真机设备上编译一个APP：Xcode Previews 里面是不含APP应用Widget组件。



#### 3：与主应用交互

根据官方文档的描述，点击Widget窗口唤起APP进行交互指定跳转支持两种方式：

* widgetURL：点击区域是Widget的所有区域，代码如下。

```
if family == .systemSmall {  // 小
  VStack(alignment: .center, spacing: 20, content: {
      
      Text(entry.quotes.author)
          .font(.system(size: 16))
      Text(entry.quotes.content[0])
          .font(.system(size: 15))
          .foregroundColor(.black)
      Text("\(entry.quotes.date) at \(entry.quotes.place) ")
          .font(.system(size: 9))
          .foregroundColor(.gray)
  })
  .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(16)
  .widgetURL(URL(string: "https://www.baidu.com/small"))

}
```

* Link：通过Link修饰，允许让界面上不同元素产生点击响应。

```
if family == .systemMedium { // 中
  
  VStack(alignment: .center, spacing: 8, content: {
      
      Text(entry.quotes.author)
          .font(.system(size: 18))
          .frame(height: 30, alignment: .top)
      
      Link(destination: URL(string: "https://www.baidu.com/medium/1")!) {
          Text(entry.quotes.content[0])
              .font(.system(size: 17))
              .foregroundColor(.black)
              .frame(maxWidth:.infinity, alignment: .leading)
      }

      Link(destination: URL(string: "https://www.baidu.com/medium/2")!) {
          Text(entry.quotes.content[1])
              .font(.system(size: 17))
              .foregroundColor(.black)
              .frame(maxWidth:.infinity, alignment: .leading)
      }
      
      Text("\(entry.quotes.date) at \(entry.quotes.place) ")
          .font(.system(size: 12))
          .foregroundColor(.gray)
          .frame(maxWidth:.infinity, alignment: .trailing)
          .frame(height: 20, alignment: .bottom)
  })
  .frame(maxWidth: .infinity, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center).padding(16)
}
```

注！：systemSmall（小组件）只支持widgetURL，而systemMedium（中组件）和 systemLarge（大组件）则都支持。Link：更希望的是不同元素的点击响应。

* 在主项目的SceneDelegate代理方法中接收回调

```
- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts {
    /// 根据不同的URL回调做出响应
    NSLog(@"%@",URLContexts);
}
```

#### 4：部分代码和方法注释

#####1：默认模板代码注释


* 提供占位的方法，作为一种没有特定属性的通用可视化视图。

```
func placeholder(in context: Self.Context) -> Self.Entry
```

* 提供表示当前时间和状态的视图，可以理解为虚假或者供用户临时选择组件的展示信息。可用展示在Add Widget页面数据。

```
func getSnapshot(in context: Self.Context, completion: @escaping (Self.Entry) -> Void)
```

* 提供视图更新数组，或者说跟上面方法形成对比的真实信息数，通过时间线来显示。可设置更新时间 如下方refreshDate的定义则是告诉组件每隔5分钟重新加载一次。

```
func getTimeline(in context: Self.Context, completion: @escaping (Timeline<Self.Entry>) -> Void)

/// 这是更新时间5minute
let refreshDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!

```

注！： 苹果原文档中有一段

> Display Dynamic Dates
Because your widget extension is not always running, you can’t directly update your widget’s content. Instead, WidgetKit renders your widget’s view on your behalf and displays the result. However, some SwiftUI views let you display content that continues updating while your widget is visible.

由于您的窗口小部件扩展程序并不总是运行，因此您无法直接更新窗口小部件的内容。而是，WidgetKit代表您渲染窗口小部件的视图并显示结果。但是，某些SwiftUI视图可让您显示在可见窗口小部件时会继续更新的内容。

导致无法预测何时更新Widget。即使在上面设置了5分钟后再次获取时间轴本身进行更新，也无法保证iOS会同时更新视图。从而造成一定的Widget页面更新延迟。

* 苹果因为提供了一个单独的方法，调用来重新加载所有窗口小部件

```
/// 控件的所有已配置小部件重新加载时间线
/// 包含应用程序。
WidgetCenter.shared.reloadAllTimelines()
```


#####2：对于支持多个Widget和小、大、中页面数据布局的思考？

在查看苹果api之前我比较困惑的有两点？

* 如何定义多个Widget，并且小、中、大的布局完全不同，是否可以通过单个扩展项目可以实现

* 数据的定义和更新

上面通过默认方法的介绍，第二个问题已经解决了。

iOS14中Widget是支持通过创建一个扩展项目返回一个或多个小部件的，可以使您的应用提供多种小部件选择。并且在项目中视图通过WidgetFamily的枚举自定义自己想要的组件和布局。

* WidgetFamily枚举

```
public enum WidgetFamily : Int, RawRepresentable, CustomDebugStringConvertible, CustomStringConvertible {

    /// A small widget.
    case systemSmall

    /// A medium-sized widget.
    case systemMedium

    /// A large widget.
    case systemLarge
}
```

* 可以通过修改原Widget入口文件方法添加更多配置来支持多个Widget：

```
@main
struct SwiftWidgetsBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        Widget1()
        Widget2()
        Widget3()
        Widget4()
        ...
    }
}
```

#### 5：样式/演示

* 在编写Widget的过程中你可以直观查看你的组件预览，就如你开发SwiftUI那样，可以实时的Resume。

![组件预览](https://tva1.sinaimg.cn/large/007S8ZIlgy1gj0jnupwn6j31oh0u0tws.jpg)


* WidgetDemo完整演示

![组件和点击响应演示](https://tva1.sinaimg.cn/large/007S8ZIlgy1gj0k43rb62g307p0go1kz.gif)

#### 6：项目地址

* 欢迎下载WidgetDemo查看更多关于演示项目中的源码。

* 项目github地址：[iOS14WidgetDemo](https://github.com/RocketsChen/iOS14WidgetDemo)

### 4：参考文献

* [Apple-widgets](https://developer.apple.com/design/human-interface-guidelines/ios/system-capabilities/widgets)

* [Widgetkit](https://developer.apple.com/documentation/widgetkit)

* [Widget-up-to-date](https://developer.apple.com/documentation/widgetkit/keeping-a-widget-up-to-date)

* [Making a Configurable Widget](https://developer.apple.com/documentation/widgetkit/making-a-configurable-widget)

* [How to create Widgets in iOS 14 in Swift](https://swiftrocks.com/ios-14-widget-tutorial-mini-apps)

### 5：总结

更新完iOS14 不管是在用户的使用上，还是Widget组件的开发的过程中体验都更顺滑了。除了要切换成SwiftUI的开发时间成本来说，把项目的组件完成最新形式还是很吸引人的，开发上也很舒适。

玩具感很强，感觉还有很多要更新和补充的东西。

新的Widget组件还支持用户用户配置（Include Configuration Intent）这一点demo没有演示到，后续有需要我会在更新下。

最后文档中如果有理解有误的地方，欢迎反馈，我将及时更新和修正。




