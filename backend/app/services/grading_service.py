import re
from typing import Any, List, Union


def normalize_text(text: str) -> str:
    if not text:
        return ""
    # Lowercase & trim
    t = text.lower().strip()
    # Normalize dashes and hyphens to space or single dash
    t = re.sub(r"[\s\-_]+", " ", t)
    # Remove surrounding quotes or punctuation
    t = t.strip(".,;:\"'!?()[]{}")
    return t


def expand_parentheses(text: str) -> List[str]:
    """
    Expands optional words in brackets, e.g. 'grass(es)' -> ['grass', 'grasses', 'grass(es)'],
    '(insulating) fat' -> ['insulating fat', 'fat']
    """
    variants = [text]
    # Match something like (insulating) or (s)
    match = re.search(r"\((.*?)\)", text)
    if match:
        optional_part = match.group(1)
        # Variant with the optional part included
        with_part = text.replace(f"({optional_part})", optional_part).strip()
        # Variant without the optional part
        without_part = text.replace(f"({optional_part})", "").strip()
        variants.extend([with_part, without_part])
        # Clean extra spaces
        variants = [re.sub(r"\s+", " ", v).strip() for v in variants if v.strip()]
    return list(set(variants))


def check_answer(given_answer: str, correct_answers: Union[List[Any], str]) -> bool:
    if not given_answer:
        return False

    norm_given = normalize_text(given_answer)
    if not norm_given:
        return False

    if isinstance(correct_answers, str):
        correct_list = [correct_answers]
    elif isinstance(correct_answers, list):
        correct_list = correct_answers
    else:
        correct_list = [str(correct_answers)]

    for target in correct_list:
        target_str = str(target).strip()
        all_target_variants = expand_parentheses(target_str)
        # Also split on '/' or ' OR ' if present
        sub_variants = []
        for v in all_target_variants:
            if "/" in v:
                sub_variants.extend([p.strip() for p in v.split("/")])
            if " or " in v.lower():
                sub_variants.extend([p.strip() for p in re.split(r"\s+or\s+", v, flags=re.IGNORECASE)])
            sub_variants.append(v)

        for variant in sub_variants:
            if normalize_text(variant) == norm_given:
                return True

    return False
