import 'package:flutter/material.dart';
import 'package:select_field/src/option.dart';
import 'package:select_field/src/menu_decoration.dart';
import 'package:select_field/src/select_field/select_field_menu_controller.dart';

class OptionsMenu<T> extends StatefulWidget {
  final LayerLink link;
  final List<Option<T>> options;
  final Option<T>? initialOption;
  final TextEditingController textController;
  final MenuPosition position;
  final void Function(Option<T> option) onOptionSelected;
  final MenuDecoration<T>? decoration;
  final SelectFieldMenuController menuController;
  final Widget Function(
    BuildContext context,
    Option<T> option,
    void Function(Option<T> option) onItemPressed,
  )? builder;

  const OptionsMenu({
    Key? key,
    required this.link,
    required this.options,
    required this.initialOption,
    required this.textController,
    required this.position,
    required this.onOptionSelected,
    required this.decoration,
    required this.menuController,
    required this.builder,
  }) : super(key: key);

  @override
  State<OptionsMenu<T>> createState() => _OptionsMenuState<T>();
}

class _OptionsMenuState<T> extends State<OptionsMenu<T>> {
  bool isOverlayAbove = false;
  Option<T>? selectedOption;
  bool hideBoxDecoration = true;

  double get overlayHeight {
    if (!widget.menuController.isExpanded) {
      return 0;
    }
    return widget.decoration?.height ?? 365;
  }

  Offset get displayOffset {
    final borderWidth = Theme.of(context)
            .inputDecorationTheme
            .focusedBorder
            ?.borderSide
            .width ??
        0;

    if (widget.position == MenuPosition.below) {
      return Offset(0, widget.link.leaderSize!.height + borderWidth);
    }

    return Offset(0, -widget.link.leaderSize!.height - borderWidth);
  }

  Alignment get alignment {
    return switch (widget.decoration?.alignment) {
      MenuAlignment.left =>
        isOverlayAbove ? Alignment.bottomLeft : Alignment.topLeft,
      MenuAlignment.right =>
        isOverlayAbove ? Alignment.bottomRight : Alignment.topRight,
      _ => isOverlayAbove ? Alignment.bottomCenter : Alignment.topCenter,
    };
  }

  void onOptionSelected(Option<T> option) {
    selectedOption = option;
    widget.onOptionSelected(option);
  }

  void initSetup() {
    if (widget.initialOption != null) {
      selectedOption = widget.initialOption;
    }

    isOverlayAbove = widget.position == MenuPosition.above;

    if (widget.menuController.isExpanded) {
      hideBoxDecoration = false;
    }
  }

  @override
  void initState() {
    super.initState();

    initSetup();

    widget.menuController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) {
          if (widget.menuController.isExpanded) {
            hideBoxDecoration = false;
          }
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
      link: widget.link,
      showWhenUnlinked: false,
      offset: displayOffset,
      targetAnchor: alignment,
      followerAnchor: alignment,
      child: TapRegion(
        groupId: SelectFieldTapRegion.fieldAndOverlay,
        child: Material(
          color: Colors.transparent,
          child: AnimatedContainer(
            margin: widget.decoration?.margin,
            duration: widget.decoration?.animationDuration ??
                const Duration(milliseconds: 350),
            onEnd: () {
              if (!widget.menuController.isExpanded) {
                setState(() {
                  hideBoxDecoration = true;
                });
              }
            },
            clipBehavior: !hideBoxDecoration ? Clip.hardEdge : Clip.none,
            height: overlayHeight,
            decoration: !hideBoxDecoration
                ? widget.decoration?.backgroundDecoration ??
                    BoxDecoration(
                      color: Theme.of(context).inputDecorationTheme.fillColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          offset: Offset(0, isOverlayAbove ? -1 : 1),
                        )
                      ],
                    )
                : null,
            child: ListView.separated(
              reverse: isOverlayAbove,
              shrinkWrap: true,
              itemCount: widget.options.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final option = widget.options[index];
                final isSelected = option == selectedOption;

                if (widget.builder != null) {
                  return widget.builder!(context, option, onOptionSelected);
                }

                return TextButton(
                  onPressed: () => onOptionSelected(option),
                  style: widget.decoration?.buttonStyle ??
                      TextButton.styleFrom(
                        fixedSize: const Size(double.infinity, 60),
                        backgroundColor:
                            Theme.of(context).inputDecorationTheme.fillColor,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(16),
                        shape: const RoundedRectangleBorder(),
                      ),
                  child: widget.decoration?.childBuilder != null
                      ? widget.decoration!.childBuilder!(context, option)
                      : Row(
                          children: [
                            Expanded(
                              child: Text(
                                option.label,
                                style: widget.decoration?.textStyle ??
                                    widget.decoration?.buttonStyle?.textStyle
                                        ?.resolve({}) ??
                                    TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textButtonTheme
                                          .style
                                          ?.foregroundColor
                                          ?.resolve({}),
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle_outline_rounded,
                                color: Theme.of(context)
                                    .textButtonTheme
                                    .style
                                    ?.foregroundColor
                                    ?.resolve({}),
                              )
                          ],
                        ),
                );
              },
              separatorBuilder: (context, index) =>
                  widget.decoration?.separatorBuilder != null
                      ? widget.decoration!.separatorBuilder!(context, index)
                      : Container(
                          height: 1,
                          width: double.infinity,
                          color: Theme.of(context).dividerColor,
                        ),
            ),
          ),
        ),
      ),
    );
  }
}

enum SelectFieldTapRegion {
  fieldAndOverlay,
}
