import 'package:flutter/material.dart';
import 'package:ipotec/auth_module/models/stock_gainers_model.dart';
import 'package:ipotec/utilities/common/cached_image_network_container.dart';
import 'package:ipotec/utilities/constants/functions.dart';

class StocksCard extends StatelessWidget {
  const StocksCard({super.key, this.data});

  final List<Data>? data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data?.length ?? 0,
      itemBuilder: (context, index) {
        final stockData = data?[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              CachedImageNetworkContainer(
                height: 52,
                width: 52,
                url: "https://assets.tickertape.in/stock-logos/${stockData?.sid}.png",
                placeHolder: buildPlaceHolderGrowPath(assetPath: stockData?.name ?? ""),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ('${stockData?.name?.split('').take(26).join('')}...'),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    stockData?.ticker ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹${stockData?.price?.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    "${stockData?.change?.toStringAsFixed(2)}%",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: getPercentageColor(stockData?.change?.toString() ?? ""),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10);
      },
    );
  }
}
