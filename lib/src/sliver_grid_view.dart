// @description:
// @date :2024/5/15
// @author by irwin

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliver_grid_view/src/sliver_index_path.dart';
import 'package:sliver_grid_view/src/sliver_sticky_delegate.dart';

class SliverGridView extends StatefulWidget {
  // section count
  final int sections;

  // can set a separate grid delegate for each section
  final SliverGridDelegate Function(int section) gridDelegate;

  // item
  final Widget Function(BuildContext context, SliverIndexPath indexPath)
      itemBuilder;

  // rows for each section
  final int Function(int section) rowsInSection;

  // header for each section
  final Widget? Function(int section)? sectionHeaderBuilder;

  // footer for each section
  final Widget? Function(int section)? sectionFooterBuilder;

  // header for the whole gird view
  final Widget? header;

  // footer for the whole grid view
  final Widget? footer;

  // the persistent header, between header and first section
  final Widget? persistentHeader;

  // the persistent header max height
  final double persistentHeaderMaxHeight;

  // the persistent header min height,
  final double persistentHeaderMinHeight;

  // navigation bar height, when you call method scrollToSection()
  final double navigationBarHeight;

  // the duration, when you call method scrollToSection()
  final Duration? scrollDuration;

  // whether need section’s click，click and scroll this section to top
  final bool sectionClickToScroll;

  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final ScrollBehavior? scrollBehavior;
  final bool shrinkWrap;
  final Key? center;
  final double anchor;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final EdgeInsetsGeometry? padding;

  const SliverGridView({
    super.key,
    required this.sections,
    required this.gridDelegate,
    required this.itemBuilder,
    required this.rowsInSection,
    this.sectionHeaderBuilder,
    this.sectionFooterBuilder,
    this.header,
    this.footer,
    this.persistentHeader,
    this.persistentHeaderMaxHeight = 44.0,
    this.persistentHeaderMinHeight = 44.0,
    this.navigationBarHeight = 64.0,
    this.scrollDuration,
    this.sectionClickToScroll = false,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.scrollBehavior,
    this.shrinkWrap = false,
    this.center,
    this.cacheExtent,
    this.anchor = 0.0,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    this.padding,
  });

  @override
  State<SliverGridView> createState() => _SliverGridViewState();
}

class _SliverGridViewState extends State<SliverGridView> {
  final List<GlobalKey> keys = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: widget.padding ?? EdgeInsets.zero,
      child: CustomScrollView(
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        controller: widget.controller,
        primary: widget.primary,
        physics: widget.physics,
        scrollBehavior: widget.scrollBehavior,
        shrinkWrap: widget.shrinkWrap,
        center: widget.center,
        cacheExtent: widget.cacheExtent,
        anchor: widget.anchor,
        semanticChildCount: widget.semanticChildCount,
        dragStartBehavior: widget.dragStartBehavior,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        restorationId: widget.restorationId,
        clipBehavior: widget.clipBehavior,
        slivers: _buildSlivers(),
      ),
    );
  }

  List<Widget> _buildSlivers() {
    List<Widget> list = [];

    // whole grid view header
    if (widget.header != null) {
      list.add(SliverToBoxAdapter(child: widget.header));
    }

    // persistent header
    if (widget.persistentHeader != null) {
      list.add(
        SliverPersistentHeader(
          pinned: true,
          delegate: StickyWidgetDelegate(
            maxHeight: widget.persistentHeaderMaxHeight,
            minHeight: widget.persistentHeaderMinHeight,
            child: widget.persistentHeader!,
          ),
        ),
      );
    }

    // sections
    for (var section = 0; section < widget.sections; section++) {
      // section's header
      Widget? header = widget.sectionHeaderBuilder?.call(section);
      if (header != null) {
        list.add(
          SliverToBoxAdapter(
            child: _buildSectionHeader(header, section),
          ),
        );
      }

      // section's item
      list.add(
        SliverGrid.builder(
          gridDelegate: widget.gridDelegate.call(section),
          itemCount: widget.rowsInSection.call(section),
          itemBuilder: (context, index) {
            SliverIndexPath indexPath =
                SliverIndexPath(section: section, row: index);
            return widget.itemBuilder.call(context, indexPath);
          },
        ),
      );

      // section's footer
      Widget? footer = widget.sectionFooterBuilder?.call(section);
      if (footer != null) {
        list.add(SliverToBoxAdapter(child: footer));
      }
    }

    // whole grid view footer
    if (widget.footer != null) {
      list.add(SliverToBoxAdapter(child: widget.footer));
    }
    return list;
  }

  Widget _buildSectionHeader(Widget sectionHeader, int section) {
    if (widget.sectionClickToScroll) {
      GlobalKey globalKey = GlobalKey();
      keys.add(globalKey);
      return GestureDetector(
        onTap: () => scrollToSection(section),
        child: SizedBox(
          key: globalKey,
          child: sectionHeader,
        ),
      );
    } else {
      return sectionHeader;
    }
  }

  // when you click a section‘s header，scroll this section to top
  void scrollToSection(int section) {
    final RenderObject? renderBox =
        keys[section].currentContext?.findRenderObject();
    if (renderBox != null) {
      Offset offset =
          (renderBox as RenderConstrainedBox).localToGlobal(Offset.zero);
      widget.controller?.animateTo(
          offset.dy - widget.navigationBarHeight - widget.persistentHeaderMinHeight + widget.controller!.offset,
          duration: widget.scrollDuration ?? const Duration(milliseconds: 500),
          curve: Curves.easeInOut);
    }
  }
}
