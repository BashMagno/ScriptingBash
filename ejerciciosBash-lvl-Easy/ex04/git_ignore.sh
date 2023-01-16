#!/bin/bash
echo "================="
git ls-files --others --ignored --exclude-standard | cat -e
echo "================="

