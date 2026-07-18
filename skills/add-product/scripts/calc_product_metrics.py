#!/usr/bin/env python3
import argparse
import json
import math

SEA_FREIGHT_UNIT_PRICE = 25
DEFAULT_PROFIT_RATE = 0.3
DEFAULT_EXCHANGE_RATE = 7
AIR_SEA_DIVISOR = 5000
DEFAULT_DIVISOR = 6000
BIG_CARGO_THRESHOLD_KG = 15


def ceil_round(value: float) -> int:
    return math.ceil(value)


def roundup(value: float, digits: int) -> float:
    factor = 10 ** digits
    return math.ceil(value * factor) / factor


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--carton-length', type=float)
    p.add_argument('--carton-width', type=float)
    p.add_argument('--carton-height', type=float)
    p.add_argument('--carton-weight', type=float)
    p.add_argument('--pcs-per-carton', type=float)
    p.add_argument('--price-1688', type=float)
    p.add_argument('--divisor', type=float, default=DEFAULT_DIVISOR)
    p.add_argument('--sea-unit-price', type=float, default=SEA_FREIGHT_UNIT_PRICE)
    p.add_argument('--profit-rate', type=float, default=DEFAULT_PROFIT_RATE)
    p.add_argument('--exchange-rate', type=float, default=DEFAULT_EXCHANGE_RATE)
    args = p.parse_args()

    result = {}

    if all(v is not None for v in [args.carton_length, args.carton_width, args.carton_height, args.carton_weight, args.pcs_per_carton]) and args.pcs_per_carton:
        volume_weight = args.carton_length * args.carton_width * args.carton_height / args.divisor
        chargeable_per_carton = max(volume_weight, args.carton_weight)
        chargeable_per_piece = chargeable_per_carton / args.pcs_per_carton
        big_cargo_qty = ceil_round(BIG_CARGO_THRESHOLD_KG / chargeable_per_piece)
        result.update({
            'volume_weight_6000': round(volume_weight, 4),
            'chargeable_weight_per_carton': round(chargeable_per_carton, 4),
            'chargeable_weight_per_piece': round(chargeable_per_piece, 6),
            'big_cargo_qty': big_cargo_qty
        })

    if all(v is not None for v in [args.carton_length, args.carton_width, args.carton_height, args.carton_weight, args.pcs_per_carton, args.price_1688]) and args.pcs_per_carton:
        volume_weight = args.carton_length * args.carton_width * args.carton_height / args.divisor
        chargeable_per_carton = max(volume_weight, args.carton_weight)
        chargeable_per_piece = chargeable_per_carton / args.pcs_per_carton
        p1 = ((chargeable_per_piece * args.sea_unit_price + args.price_1688) / (1 - args.profit_rate)) / args.exchange_rate
        result['p1'] = roundup(p1, 2)

    print(json.dumps(result, ensure_ascii=False))


if __name__ == '__main__':
    main()
