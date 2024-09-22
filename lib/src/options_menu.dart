import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';

class OptionsMenu<T> extends StatefulWidget {
  final LayerLink link;
  final List<Option<T>> options;
  final TextEditingController textController;
  final MenuPosition position;
  final void Function(Option<T> option) onOptionSelected;
  final MenuDecoration<T>? decoration;
  final SelectFieldMenuController<T> menuController;
  final SearchOptions? searchOptions;
  final Widget Function(
    BuildContext context,
    Option<T> option,
    bool isSelected,
    void Function(Option<T> option) onItemPressed,
  )? builder;

  const OptionsMenu({
    Key? key,
    required this.link,
    required this.options,
    required this.textController,
    required this.position,
    required this.onOptionSelected,
    required this.decoration,
    required this.menuController,
    required this.searchOptions,
    required this.builder,
  }) : super(key: key);

  @override
  State<OptionsMenu<T>> createState() => _OptionsMenuState<T>();
}

class _OptionsMenuState<T> extends State<OptionsMenu<T>> {
  Option<T>? selectedOption;
  List<Option<T>> searchedOptions = [];
  bool isOverlayAbove = false;
  bool searchEnabled = false;

  double get overlayHeight {
    if (!widget.menuController.isExpanded) {
      return 0;
    }

    final menuOverallHeight = widget.decoration?.height ?? 365;

    if (searchEnabled) {
      final optionsHeight = widget.searchOptions!.height;
      final newHeight = searchedOptions.length * optionsHeight;

      return newHeight > menuOverallHeight ? menuOverallHeight : newHeight;
    }

    return menuOverallHeight;
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

  bool isOptionSelected(Option<T> option) {
    bool isSelected = option == widget.menuController.selectedOption;

    if (widget.menuController is MultiSelectFieldMenuController) {
      final controller =
          widget.menuController as MultiSelectFieldMenuController;
      isSelected = controller.selectedOptions.contains(option);
    }

    return isSelected;
  }

  void onOptionSelected(Option<T> option) {
    selectedOption = option;
    widget.onOptionSelected(option);
  }

  List<Option<T>> filteredOptions() {
    final query = widget.textController.text;

    final filtered = widget.options.where((option) {
      final filter = widget.searchOptions!.filterBy;
      if (filter != null) {
        return filter(option, query);
      }

      return option.label.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return filtered;
  }

  @override
  void initState() {
    super.initState();
    searchEnabled = widget.searchOptions != null;
    if (searchEnabled) {
      searchedOptions = filteredOptions();
    }

    isOverlayAbove = widget.position == MenuPosition.above;

    widget.menuController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) {
          setState(() {});
        }
      });
    });

    if (searchEnabled) {
      widget.textController.addListener(() {
        if (mounted) {
          setState(() {
            searchedOptions = filteredOptions();
          });
        }
      });
    }
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
            height: overlayHeight,
            decoration: widget.decoration?.backgroundDecoration ??
                BoxDecoration(
                  color: Theme.of(context).inputDecorationTheme.fillColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      offset: Offset(0, isOverlayAbove ? -1 : 1),
                    )
                  ],
                ),
            clipBehavior: Clip.hardEdge,
            child: ListView.separated(
              reverse: isOverlayAbove,
              shrinkWrap: true,
              itemCount: searchEnabled
                  ? searchedOptions.length
                  : widget.options.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final option = searchEnabled
                    ? searchedOptions[index]
                    : widget.options[index];
                final isSelected = isOptionSelected(option);

                if (widget.builder != null) {
                  final builder = widget.builder!(
                      context, option, isSelected, onOptionSelected);

                  return searchEnabled
                      ? ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: widget.searchOptions!.height,
                          ),
                          child: builder,
                        )
                      : builder;
                }

                return TextButton(
                  onPressed: () => onOptionSelected(option),
                  style: widget.decoration?.buttonStyle ??
                      TextButton.styleFrom(
                        fixedSize: Size(double.infinity,
                            searchEnabled ? widget.searchOptions!.height : 60),
                        backgroundColor:
                            Theme.of(context).inputDecorationTheme.fillColor,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(16),
                        shape: const RoundedRectangleBorder(),
                      ),
                  child: widget.decoration?.childBuilder != null
                      ? widget.decoration!.childBuilder!(
                          context, option, isSelected)
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
